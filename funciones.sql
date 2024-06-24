create trigger calcular_importe_trigger
before insert on PASADAS
for each row
execute function calcular_importe();

CREATE OR REPLACE FUNCTION dbd2gb03.calcular_importe()
RETURNS trigger
LANGUAGE plpgsql
AS $function$
DECLARE
    tipo_de_vehiculo INT;
    rfid_id VARCHAR(15);
    bonificacion_por INTEGER;
    importe_temp NUMERIC(5,2);
    cabina_rfid BOOLEAN;
    numero_cuenta bigint;
   	id_peaje_bonificacion SMALLINT;
begin
	--Se busca la cuenta 
	select c. nro_cuenta
	into numero_cuenta
	from propietarios_vehiculos pv join cuentas c on pv.id_pers = c.id_pers_titular
	where pv.matricula = new.matricula;
	
    -- Obtener tipo_vehiculo y rfid_id para la matricula en 'new'
    SELECT v.tipo_vehiculo, v.id_tag
    INTO tipo_de_vehiculo, rfid_id
    FROM dbd2gb03.vehiculos v 
    WHERE v.matricula = NEW.matricula;

    -- Obtener porcentaje de bonificacion (si existe)
    SELECT tb.porcentaje, b.id_peaje
    INTO bonificacion_por, id_peaje_bonificacion
    FROM dbd2gb03.bonificaciones b JOIN dbd2gb03.tipos_bonificaciones tb ON b.id_bonificacion = tb.id_bonificacion
    WHERE b.matricula = NEW.matricula;

    -- Obtener si la cabina es rfid
    SELECT cp.tiene_rfid 
    INTO cabina_rfid
    FROM cabina_peajes cp 
    WHERE NEW.id_peaje = cp.id_peaje AND NEW.nro_cabina = cp.nro_cabina;
    
    -- Calcular importe y cod tarifa basado en tipo_vehiculo y rfid_id 
    SELECT 
        CASE WHEN rfid_id IS NOT NULL AND cabina_rfid THEN t.valor_telepeaje ELSE t.valor_estandar END, t.codigo
    INTO importe_temp, NEW.cod_tarifa
    FROM dbd2gb03.tarifas t
    WHERE t.tipo_vehiculo = tipo_de_vehiculo
      AND NEW.fecha_hora BETWEEN t.fecha_desde AND t.fecha_hasta;

    -- Aplicar bonificacion si existe
    IF bonificacion_por IS NOT NULL AND NEW.id_peaje = id_peaje_bonificacion AND cabina_rfid THEN
        NEW.importe := importe_temp * (1 - bonificacion_por / 100.0);
    ELSE
        NEW.importe := importe_temp;
    END IF;

    new.nro_cuenta = numero_cuenta;
   
   -- Revisa si el saldo es sufuciente
    IF EXISTS (SELECT 1
    	FROM cuentas c
    	WHERE c.nro_cuenta = numero_cuenta
    	AND c.saldo < NEW.importe) THEN 
    	raise EXCEPTION 'Saldo insuficiente';
    END IF;
    
    update dbd2gb03.cuentas 
    set saldo = saldo - new.importe
    WHERE cuentas.nro_cuenta = new.nro_cuenta;

    RETURN NEW;
END;
$function$;


CREATE OR REPLACE FUNCTION cargar_saldo(saldo_add numeric(6,2), nro_cuenta_param bigint)
RETURNS void AS $$
BEGIN 
	
	IF saldo_add < 0 THEN
		RAISE EXCEPTION  'Saldo no valido';
	END IF; 

	IF NOT EXISTS (SELECT 1 FROM dbd2gb03.cuentas WHERE nro_cuenta = nro_cuenta_param) THEN 
		RAISE EXCEPTION 'Cuenta no existente';
	END IF; 
	
    UPDATE dbd2gb03.cuentas 
    SET saldo = saldo + saldo_add
    WHERE cuentas.nro_cuenta = nro_cuenta_param;

    RAISE NOTICE 'Saldo cargado correctamente para cuenta %', nro_cuenta_param;    
END;
$$ LANGUAGE plpgsql;


update cuentas 
set saldo = 0;

select dbd2gb03.cargar_saldo(9999.00,1);
select dbd2gb03.cargar_saldo(9999.00,2);
select dbd2gb03.cargar_saldo(9999.00,3);
select dbd2gb03.cargar_saldo(9999.00,4);
select dbd2gb03.cargar_saldo(9999.00,5);
select dbd2gb03.cargar_saldo(9999.00,6);