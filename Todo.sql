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
	fecha_hasta date,
	check (fecha_hasta is null or fecha_hasta > fecha_desde)
);


create table PERSONAS(
	id_pers bigserial primary key,
	nro_doc varchar(15) not null,
	codigo_pais varchar(2) not null,
	tipo_doc varchar(3) not null,
	nombre varchar(30) not null,
	apellido varchar(30) not null
	check (codigo_pais in ('UY','AR','BR','PY','CL') and tipo_doc in ('DNI','CI','PA'))
);


create table CUENTAS(
	nro_cuenta bigserial primary key,
	id_pers_titular bigint references PERSONAS(id_pers),
	fecha_alta timestamp not null,
	saldo numeric(6,2) not null,
	check (saldo >= 0)
);

create table VEHICULOS(
	matricula varchar(10) primary key,
	modelo varchar(15) not null,
	tipo_vehiculo smallint references TIPO_VEHICULOS(tipo),
	nro_chasis varchar(20) not null,
	nro_motor varchar(20) not null,
	id_tag varchar(15),
	nro_cuenta bigint references cuentas(nro_cuenta)
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
	descripcion varchar(50) not null,
	check (porcentaje > 0 and porcentaje < 100)
);

create table BONIFICACIONES(
	matricula varchar(10) references VEHICULOS(matricula),
	id_peaje smallint references PEAJES(id_peaje),
	id_bonificacion smallint references TIPOS_BONIFICACIONES(id_bonificacion),
	fecha_desde date not null,
	fecha_hasta date,
	primary key (matricula, id_peaje, id_bonificacion, fecha_desde),
	check (fecha_hasta is null or fecha_hasta > fecha_desde)
);

create table PASADAS(
	matricula VARCHAR(10) references VEHICULOS(matricula),
	id_peaje smallint not null,
	nro_cabina smallint not null,
	fecha_hora timestamp not null,
	importe numeric(5,2), 
	nro_cuenta bigint references CUENTAS(nro_cuenta),
	cod_tarifa integer references TARIFAS(codigo),
	FOREIGN KEY (id_peaje, nro_cabina) REFERENCES CABINA_PEAJES(id_peaje, nro_cabina),
	primary key (matricula, fecha_hora)
);


INSERT INTO dbd2gb03.tipo_vehiculos
(tipo, descripcion)
VALUES(nextval('tipo_vehiculos_tipo_seq'::regclass), 'Autos y camionetas');

INSERT INTO dbd2gb03.tipo_vehiculos
(tipo, descripcion)
VALUES(nextval('tipo_vehiculos_tipo_seq'::regclass), 'Tractor y ómnibus hasta 25 pas');

INSERT INTO dbd2gb03.tipo_vehiculos
(tipo, descripcion)
VALUES(nextval('tipo_vehiculos_tipo_seq'::regclass), 'Vehículos o equipos de carga');

INSERT INTO dbd2gb03.tipo_vehiculos
(tipo, descripcion)
VALUES(nextval('tipo_vehiculos_tipo_seq'::regclass), 'Ómnibus de más de 25 pas');

INSERT INTO dbd2gb03.tipo_vehiculos
(tipo, descripcion)
VALUES(nextval('tipo_vehiculos_tipo_seq'::regclass), 'Vehiculos 3 ejes más 6 ruedas');

INSERT INTO dbd2gb03.tipo_vehiculos
(tipo, descripcion)
VALUES(nextval('tipo_vehiculos_tipo_seq'::regclass), 'Vehículos de 4 o más ejes');

INSERT INTO dbd2gb03.tipo_vehiculos
(tipo, descripcion)
VALUES(nextval('tipo_vehiculos_tipo_seq'::regclass), 'Vehículos de carga tritrenes');


INSERT INTO dbd2gb03.tarifas
(codigo, tipo_vehiculo, valor_estandar, valor_telepeaje, fecha_desde, fecha_hasta)
VALUES(nextval('tarifas_codigo_seq'::regclass), 1, 185.00, 142.98, '2023-08-15', '2024-12-31');

INSERT INTO dbd2gb03.tarifas
(codigo, tipo_vehiculo, valor_estandar, valor_telepeaje, fecha_desde, fecha_hasta)
VALUES(nextval('tarifas_codigo_seq'::regclass), 2, 185.00, 142.98, '2023-08-15', '2024-12-31');

INSERT INTO dbd2gb03.tarifas
(codigo, tipo_vehiculo, valor_estandar, valor_telepeaje, fecha_desde, fecha_hasta)
VALUES(nextval('tarifas_codigo_seq'::regclass), 3, 265.00, 207.97, '2023-12-31', '2024-12-31');

INSERT INTO dbd2gb03.tarifas
(codigo, tipo_vehiculo, valor_estandar, valor_telepeaje, fecha_desde, fecha_hasta)
VALUES(nextval('tarifas_codigo_seq'::regclass), 4, 265.00, 207.97, '2023-12-31', '2024-12-31');

INSERT INTO dbd2gb03.tarifas
(codigo, tipo_vehiculo, valor_estandar, valor_telepeaje, fecha_desde, fecha_hasta)
VALUES(nextval('tarifas_codigo_seq'::regclass), 5, 265.00, 207.97, '2023-12-31', '2024-12-31');

INSERT INTO dbd2gb03.tarifas
(codigo, tipo_vehiculo, valor_estandar, valor_telepeaje, fecha_desde, fecha_hasta)
VALUES(nextval('tarifas_codigo_seq'::regclass), 6, 545.00, 424.61, '2024-03-22', '2024-12-31');

INSERT INTO dbd2gb03.tarifas
(codigo, tipo_vehiculo, valor_estandar, valor_telepeaje, fecha_desde, fecha_hasta)
VALUES(nextval('tarifas_codigo_seq'::regclass), 7, 910.00, 710.58, '2024-03-22', '2024-12-31');


INSERT INTO dbd2gb03.personas
(id_pers, nro_doc, codigo_pais, tipo_doc, nombre, apellido)
VALUES(nextval('personas_id_pers_seq'::regclass), '45276133', 'UY', 'CI', 'Ignacio', 'Borreani');

INSERT INTO dbd2gb03.personas
(id_pers, nro_doc, codigo_pais, tipo_doc, nombre, apellido)
VALUES(nextval('personas_id_pers_seq'::regclass), '52848962', 'UY', 'CI', 'Gabriel', 'Baru');

INSERT INTO dbd2gb03.personas
(id_pers, nro_doc, codigo_pais, tipo_doc, nombre, apellido)
VALUES(nextval('personas_id_pers_seq'::regclass), '38948549', 'UY', 'CI', 'Agustin', 'Casanova');

INSERT INTO dbd2gb03.personas
(id_pers, nro_doc, codigo_pais, tipo_doc, nombre, apellido)
VALUES(nextval('personas_id_pers_seq'::regclass), '10004230440', 'AR', 'DNI', 'Joe', 'Biden');

INSERT INTO dbd2gb03.personas
(id_pers, nro_doc, codigo_pais, tipo_doc, nombre, apellido)
VALUES(nextval('personas_id_pers_seq'::regclass), '20438549', 'UY', 'CI', 'Diego', 'Garcia');

INSERT INTO dbd2gb03.personas
(id_pers, nro_doc, codigo_pais, tipo_doc, nombre, apellido)
VALUES(nextval('personas_id_pers_seq'::regclass), '82743823', 'UY', 'CI', 'Gabriel', 'Diaz');



INSERT INTO dbd2gb03.cuentas
(nro_cuenta, id_pers_titular, fecha_alta, saldo)
VALUES(nextval('cuentas_nro_cuenta_seq'::regclass), 1, '2024-06-16 17:45:32', 0);

INSERT INTO dbd2gb03.cuentas
(nro_cuenta, id_pers_titular, fecha_alta, saldo)
VALUES(nextval('cuentas_nro_cuenta_seq'::regclass), 2, '2023-05-13 20:15.21', 0);

INSERT INTO dbd2gb03.cuentas
(nro_cuenta, id_pers_titular, fecha_alta, saldo)
VALUES(nextval('cuentas_nro_cuenta_seq'::regclass), 3, '2023-12-30 11:11:11', 0);

INSERT INTO dbd2gb03.cuentas
(nro_cuenta, id_pers_titular, fecha_alta, saldo)
VALUES(nextval('cuentas_nro_cuenta_seq'::regclass), 4, '2024-02-29 12:43:12', 0);

INSERT INTO dbd2gb03.cuentas
(nro_cuenta, id_pers_titular, fecha_alta, saldo)
VALUES(nextval('cuentas_nro_cuenta_seq'::regclass), 5, '2024-01-31 23:59:59', 0);

INSERT INTO dbd2gb03.cuentas
(nro_cuenta, id_pers_titular, fecha_alta, saldo)
VALUES(nextval('cuentas_nro_cuenta_seq'::regclass), 6, '2023-12-01 00:00:01', 0);


INSERT INTO dbd2gb03.vehiculos
(matricula, modelo, tipo_vehiculo, nro_chasis, nro_motor, id_tag, nro_cuenta)
VALUES('SCD4534', 'Camaro', 1, 'Z9R2T7F8J6W1', 'H8T3F7I4E2Q5', 'AI393D5G53JI', 1);

INSERT INTO dbd2gb03.vehiculos
(matricula, modelo, tipo_vehiculo, nro_chasis, nro_motor, id_tag, nro_cuenta)
VALUES('ABA1543', 'JDPT4045T', 2, 'Q5X3K9H4P2M7', 'V6O1J9B5N3A7', 'X31VJ16T50M8', 1);

INSERT INTO dbd2gb03.vehiculos
(matricula, modelo, tipo_vehiculo, nro_chasis, nro_motor, id_tag, nro_cuenta)
VALUES('LAC1254', 'MossyOak10060bz', 1, 'L6V2N0B4D8S1', 'R2W8K4C0P6U9', 'C0463RQYSFFM', 2);

INSERT INTO dbd2gb03.vehiculos
(matricula, modelo, tipo_vehiculo, nro_chasis, nro_motor, id_tag, nro_cuenta)
VALUES('MAA7345', 'TeslaCyberTruck', 1, 'G3Y5A1E9U7O2', 'Y5G2M7X1S3D8', '', 3);

INSERT INTO dbd2gb03.vehiculos
(matricula, modelo, tipo_vehiculo, nro_chasis, nro_motor, id_tag, nro_cuenta)
VALUES('RAB8935', 'ManTGS33-540', 7, 'W8I4C7R3M6E9', 'T1L6Z9Q3R7V4', 'N9LZPY5X5X62', 4);

INSERT INTO dbd2gb03.vehiculos
(matricula, modelo, tipo_vehiculo, nro_chasis, nro_motor, id_tag, nro_cuenta)
VALUES('BAG9542', 'NissanUltima', 1, 'S3P6X8B1R0H4', 'C3Q5D8V2Z0W6', '4X22FAUOUCO7', 5);

INSERT INTO dbd2gb03.vehiculos
(matricula, modelo, tipo_vehiculo, nro_chasis, nro_motor, id_tag, nro_cuenta)
VALUES('AAM8465', 'Peugeot 208', 1, 'O9E5K1Q7C3T2', 'B0R7U4M9O1K3', '8CL79U2SI8IM', 6);

INSERT INTO dbd2gb03.vehiculos
(matricula, modelo, tipo_vehiculo, nro_chasis, nro_motor, id_tag, nro_cuenta)
VALUES('SCL9221', 'Renault Clio', 1, 'M4D8H2W6Y1N5', 'I2F5Y7T9X4P6', '', 2);

-- Sin propietario, esta paga en efectivo
INSERT INTO dbd2gb03.vehiculos
(matricula, modelo, tipo_vehiculo, nro_chasis, nro_motor)
VALUES('LAC1234', 'Nissan Central', 1, 'YG73GFU492F', 'F3HF485DG');





INSERT INTO dbd2gb03.propietarios_vehiculos
(id_pers, matricula)
VALUES(1, 'SCD4534');

INSERT INTO dbd2gb03.propietarios_vehiculos
(id_pers, matricula)
VALUES(1, 'ABA1543');

INSERT INTO dbd2gb03.propietarios_vehiculos
(id_pers, matricula)
VALUES(2, 'LAC1254');

INSERT INTO dbd2gb03.propietarios_vehiculos
(id_pers, matricula)
VALUES(3, 'MAA7345');

INSERT INTO dbd2gb03.propietarios_vehiculos
(id_pers, matricula)
VALUES(4, 'RAB8935');

INSERT INTO dbd2gb03.propietarios_vehiculos
(id_pers, matricula)
VALUES(5, 'BAG9542');

INSERT INTO dbd2gb03.propietarios_vehiculos
(id_pers, matricula)
VALUES(6, 'AAM8465');

INSERT INTO dbd2gb03.propietarios_vehiculos
(id_pers, matricula)
VALUES(2, 'SCL9221');





INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'Centenario', 'Ruta 5', 246.000, '4664 6412', '');

INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'Manuel Dias', 'Ruta 5', 423.000, '4360 2996', '');

INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'Paso del Puerto', 'Ruta 3', 245.200, '4360 4494', '');

INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'Queguay', 'Ruta 3', 392.750, '4720 2806', '');

INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'Mercedes', 'Ruta 2', 284.400, '4560 2189', '');

INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'Cufré', 'Ruta 1', 107.250, '4550 2813', '');

INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'La Barra', 'Ruta 1 vieja', 22.300, '2347 2953', '');

INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'La Barra', 'Ruta 1', 23.450, '2347 4673', '');

INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'Cebollatí', 'Ruta 8', 206.250, '4440 8002', '');

INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'Capilla de Cella', 'Ruta 9', 79.500, '4370 7001', '');

INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'Garzón', 'Ruta 9', 191.000, '4480 6100', '');

INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'Santa Lucía', 'Ruta 11', 81.000, '4338 9354', '');

INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'Pando', 'Ruta Inter', 32.400, '4376 6554', '097324877');

INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'Solís', 'Ruta Inter', 81.000, '4438 0032', '');

INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'Mendoza', 'Ruta 5', 67.700, '4330 9268', '');

INSERT INTO dbd2gb03.peajes
(id_peaje, nombre, ruta, km, telefono, whatsapp)
VALUES(nextval('peajes_id_peaje_seq'::regclass), 'Soca', 'Ruta 8', 50.500, '4374 0455', '');

-- Las cabinas son muchas asi que se hacen en otro archivo exclusivo

INSERT INTO dbd2gb03.tipos_bonificaciones
(id_bonificacion, porcentaje, descripcion)
VALUES(nextval('tipos_bonificaciones_id_bonificacion_seq'::regclass), 25, 'trabaja del otro lado del peaje');

INSERT INTO dbd2gb03.tipos_bonificaciones
(id_bonificacion, porcentaje, descripcion)
VALUES(nextval('tipos_bonificaciones_id_bonificacion_seq'::regclass), 20, 'vive proximo al peaje');


INSERT INTO dbd2gb03.bonificaciones
(matricula, id_peaje, id_bonificacion, fecha_desde, fecha_hasta)
VALUES('RAB8935', 1, 1, '2023-11-11', '2025-11-11');

INSERT INTO dbd2gb03.bonificaciones
(matricula, id_peaje, id_bonificacion, fecha_desde, fecha_hasta)
VALUES('AAM8465', 1, 2, '2023-12-12', '2025-12-12');


INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (1, 1, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (1, 2, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (1, 3, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (1, 4, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (1, 5, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (1, 6, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (2, 1, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (2, 2, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (2, 3, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (2, 4, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (2, 5, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (2, 6, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (3, 1, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (3, 2, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (3, 3, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (3, 4, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (3, 5, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (3, 6, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (4, 1, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (4, 2, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (4, 3, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (4, 4, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (4, 5, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (4, 6, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (5, 1, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (5, 2, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (5, 3, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (5, 4, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (5, 5, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (5, 6, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (6, 1, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (6, 2, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (6, 3, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (6, 4, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (6, 5, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (6, 6, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (7, 1, 'false');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (7, 2, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (7, 3, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (7, 4, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (7, 5, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (7, 6, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (8, 1, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (8, 2, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (8, 3, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (8, 4, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (8, 5, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (8, 6, 'false');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (9, 1, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (9, 2, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (9, 3, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (9, 4, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (9, 5, 'false');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (9, 6, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (10, 1, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (10, 2, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (10, 3, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (10, 4, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (10, 5, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (10, 6, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (11, 1, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (11, 2, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (11, 3, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (11, 4, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (11, 5, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (11, 6, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (12, 1, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (12, 2, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (12, 3, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (12, 4, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (12, 5, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (12, 6, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (13, 1, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (13, 2, 'false');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (13, 3, 'false');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (13, 4, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (13, 5, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (13, 6, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (14, 1, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (14, 2, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (14, 3, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (14, 4, 'false');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (14, 5, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (14, 6, 'true');
 
INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (15, 1, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (15, 2, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (15, 3, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (15, 4, 'false');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (15, 5, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (15, 6, 'true');
 
INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (16, 1, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (16, 2, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (16, 3, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (16, 4, 'false');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (16, 5, 'true');

INSERT INTO dbd2gb03.cabina_peajes 
 (id_peaje, nro_cabina, tiene_rfid) 
 VALUES (16, 6, 'true');









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