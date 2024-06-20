CREATE OR REPLACE FUNCTION calcular_importe()
RETURNS TRIGGER AS $$
-- Obtener importe
DECLARE
    tipo_vehiculo INT;
    rfid_id VARCHAR(15);
    bonificacion_por INTEGER;
    importe_temp numeric(5,2);
BEGIN
    -- Obtener tipo_vehiculo y rfid_id para la matricula en 'new'
    SELECT v.tipo_vehiculo, v.id_tag, v.nro_cuenta
    INTO tipo_vehiculo, rfid_id, new.nro_cuenta
    FROM dbd2gb03.vehiculos v 
    WHERE v.matricula = NEW.matricula;


    -- Obtener porcentaje de bonificacion (si existe)
    SELECT tb.porcentaje
    INTO bonificacion_por
    FROM dbd2gb03.bonificaciones b
    JOIN dbd2gb03.tipos_bonificaciones tb ON b.id_bonificacion = tb.id_bonificacion
    WHERE b.matricula = NEW.matricula;

    -- Calcular importe y cod tarifa basado en tipo_vehiculo y rfid_id 
    SELECT 
        CASE WHEN rfid_id IS NOT NULL THEN t.valor_telepeaje ELSE t.valor_estandar end, t.codigo
    INTO importe_temp, NEW.cod_tarifa
    FROM dbd2gb03.tarifas t
    WHERE t.tipo_vehiculo = tipo_vehiculo
      AND NEW.fecha_hora BETWEEN t.fecha_desde AND t.fecha_hasta;
     

    -- Aplicar bonificacion si existe
    IF bonificacion_por IS NOT NULL THEN
        NEW.importe := importe_temp * (1 - bonificacion_por / 100.0);
    ELSE
        NEW.importe := importe_temp;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;





CREATE OR REPLACE FUNCTION dbd2gb03.calcular_importe()
RETURNS TRIGGER
AS $function$
DECLARE
    tipo_vehiculo INT;
    rfid_id VARCHAR(15);
    bonificacion_por INTEGER;
    importe_temp NUMERIC(5,2);
    cabina_rfid BOOLEAN;
BEGIN
    -- Obtener tipo_vehiculo y rfid_id para la matricula en 'new'
    SELECT v.tipo_vehiculo, v.id_tag
    INTO tipo_vehiculo, rfid_id
    FROM dbd2gb03.vehiculos v 
    WHERE v.matricula = NEW.matricula;

    -- Obtener porcentaje de bonificacion (si existe)
    SELECT tb.porcentaje
    INTO bonificacion_por
    FROM dbd2gb03.bonificaciones b
    JOIN dbd2gb03.tipos_bonificaciones tb ON b.id_bonificacion = tb.id_bonificacion
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
    WHERE t.tipo_vehiculo = tipo_vehiculo
      AND NEW.fecha_hora BETWEEN t.fecha_desde AND t.fecha_hasta;

    -- Verificar si importe_temp es NULL y manejarlo
    IF importe_temp IS NULL THEN
        -- Si no se encontró tarifa válida, manejar como necesario (lanzar error, asignar valor predeterminado, etc.)
        -- En este ejemplo, lanzar una excepción
        RAISE EXCEPTION 'No se encontró una tarifa válida para el vehículo/matricula % en la fecha %', NEW.matricula, NEW.fecha_hora;
    END IF;

    -- Aplicar bonificacion si existe
    IF bonificacion_por IS NOT NULL THEN
        NEW.importe := importe_temp * (1 - bonificacion_por / 100.0);
    ELSE
        NEW.importe := importe_temp;
    END IF;

    -- Asegurarse de que cod_tarifa y nro_cuenta no sean NULL
    IF NEW.cod_tarifa IS NULL THEN
        NEW.cod_tarifa := 0; -- Asignar un valor predeterminado si no se pudo calcular cod_tarifa
    END IF;

    IF NEW.nro_cuenta IS NULL THEN
        -- Lanzar una excepción si no se pudo determinar el número de cuenta
        RAISE EXCEPTION 'No se pudo determinar el número de cuenta para la matrícula %', NEW.matricula;
    END IF;

    RETURN NEW;
END;
$function$ LANGUAGE plpgsql;




create trigger calcular_importe_trigger
before insert on PASADAS
for each row
execute function calcular_importe();



CREATE OR REPLACE FUNCTION cuenta_vehiculo()
RETURNS TRIGGER AS $$
BEGIN
    -- Obtener tipo_vehiculo y rfid_id para la matricula en 'new'
    SELECT c.nro_cuenta
    into new.nrp_cuenta
    FROM dbd2gb03.vehiculos v 
    		join propietarios_vehiculos pv on (pv.matricula = v.matricula)
    		join cuentas c on (c.id_pers_titular = pv.id_pers)
    WHERE v.matricula = NEW.matricula;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

create trigger cuenta_vehiculos_trigger
before insert on VEHICULOS
for each row
execute function cuenta_vehiculo();



CREATE OR REPLACE FUNCTION cargar_saldo(saldo_add numeric(6,2), nro_cuenta_param bigint)
RETURNS void AS $$
BEGIN 
    UPDATE dbd2gb03.cuentas 
    SET saldo = saldo + saldo_add
    WHERE cuentas.nro_cuenta = nro_cuenta_param;

    RAISE NOTICE 'Saldo cargado correctamente para cuenta %', nro_cuenta_param;    
END;
$$ LANGUAGE plpgsql;


select dbd2gb03.cargar_saldo(111.00,1);