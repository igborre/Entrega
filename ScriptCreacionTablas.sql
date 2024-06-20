create table TIPO_VEHICULOS(
	tipo smallserial primary key,
	descripcion varchar(30) not null
);

create table TARIFAS(
	codigo serial primary key,
	tipo_vehiculo smallint references TIPO_VEHICULOS(tipo),
	valor_estandar numeric(5,2) not null,
	valor_telepeaje numeric(5,2) not null,
	fecha_desde date not null,
	fecha_hasta date not null
);


create table PERSONAS(
	id_pers bigserial primary key,
	nro_doc varchar(15) not null,
	codigo_pais varchar(2) not null,
	tipo_doc varchar(3) not null,
	nombre varchar(30) not null,
	apellido varchar(30) not null
);


create table CUENTAS(
	nro_cuenta bigserial primary key,
	id_pers_titular bigint references PERSONAS(id_pers),
	fecha_alta timestamp not null,
	saldo numeric(6,2)
);

create table VEHICULOS(
	matricula varchar(10) primary key,
	modelo varchar(15) not null,
	tipo_vehiculo smallint references TIPO_VEHICULOS(tipo),
	nro_chasis varchar(20) not null,
	nro_motor varchar(20) not null,
	id_tag varchar(15),
	nro_cuenta bigint not null references cuentas.nro_cuenta
);


create table PROPIETARIOS_VEHICULOS(
	id_pers bigint references PERSONAS(id_pers),
	matricula varchar(10) references VEHICULOS(matricula),
	primary key (id_pers, matricula)
);


create table PEAJES(
	id_peaje smallserial primary key,
	nombre varchar(30) not null,
	ruta varchar(20) not null,
	km numeric(6,3) not null,
	telefono varchar(9) not null,
	whatsapp varchar(9)
);

create table CABINA_PEAJES(
	id_peaje smallint references PEAJES(id_peaje),
	nro_cabina smallserial not null,
	tiene_rfid boolean not null,
	primary key (id_peaje, nro_cabina)
);

create table TIPOS_BONIFICACIONES(
	id_bonificacion smallserial	primary key,
	porcentaje integer not null,
	descripcion varchar(50) not null
);

create table BONIFICACIONES(
	matricula varchar(10) references VEHICULOS(matricula),
	id_peaje smallint references PEAJES(id_peaje),
	id_bonificacion smallint references TIPOS_BONIFICACIONES(id_bonificacion),
	fecha_desde date not null,
	fecha_hasta date not null,
	primary key (matricula, id_peaje, id_bonificacion, fecha_desde)
);

create table PASADAS(
	matricula VARCHAR(10) references VEHICULOS(matricula),
	id_peaje smallint not null,
	nro_cabina smallint not null,
	fecha_hora timestamp not null,
	importe numeric(5,2) ,
	nro_cuenta bigint references CUENTAS(nro_cuenta),
	cod_tarifa integer references TARIFAS(codigo),
	FOREIGN KEY (id_peaje, nro_cabina) REFERENCES CABINA_PEAJES(id_peaje, nro_cabina),
	primary key (matricula, fecha_hora)
);

insert into dbd2gb03.pasadas 
(matricula, id_peaje, nro_cabina, fecha_hora)
VALUES('BAG9542',4,2,'2024-05-11 08:39:45')

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


