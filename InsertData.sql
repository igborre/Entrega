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
VALUES(nextval('tarifas_codigo_seq'::regclass), 1, 142.98, 185.00, '2023-08-15', '2024-12-31');

INSERT INTO dbd2gb03.tarifas
(codigo, tipo_vehiculo, valor_estandar, valor_telepeaje, fecha_desde, fecha_hasta)
VALUES(nextval('tarifas_codigo_seq'::regclass), 2, 142.98, 185.00, '2023-08-15', '2024-12-31');

INSERT INTO dbd2gb03.tarifas
(codigo, tipo_vehiculo, valor_estandar, valor_telepeaje, fecha_desde, fecha_hasta)
VALUES(nextval('tarifas_codigo_seq'::regclass), 3, 207.97, 265.00, '2023-12-31', '2024-12-31');

INSERT INTO dbd2gb03.tarifas
(codigo, tipo_vehiculo, valor_estandar, valor_telepeaje, fecha_desde, fecha_hasta)
VALUES(nextval('tarifas_codigo_seq'::regclass), 4, 207.97, 265.00, '2023-12-31', '2024-12-31');

INSERT INTO dbd2gb03.tarifas
(codigo, tipo_vehiculo, valor_estandar, valor_telepeaje, fecha_desde, fecha_hasta)
VALUES(nextval('tarifas_codigo_seq'::regclass), 5, 207.97, 265.00, '2023-12-31', '2024-12-31');

INSERT INTO dbd2gb03.tarifas
(codigo, tipo_vehiculo, valor_estandar, valor_telepeaje, fecha_desde, fecha_hasta)
VALUES(nextval('tarifas_codigo_seq'::regclass), 6, 424.61, 545.00, '2024-03-22', '2024-12-31');

INSERT INTO dbd2gb03.tarifas
(codigo, tipo_vehiculo, valor_estandar, valor_telepeaje, fecha_desde, fecha_hasta)
VALUES(nextval('tarifas_codigo_seq'::regclass), 7, 710.58, 910, '2024-03-22', '2024-12-31');


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
VALUES(nextval('personas_id_pers_seq'::regclass), '10004230440', 'US', 'SSN', 'Joe', 'Biden');

INSERT INTO dbd2gb03.personas
(id_pers, nro_doc, codigo_pais, tipo_doc, nombre, apellido)
VALUES(nextval('personas_id_pers_seq'::regclass), '20438549', 'UY', 'CI', 'Diego', 'Garcia');

INSERT INTO dbd2gb03.personas
(id_pers, nro_doc, codigo_pais, tipo_doc, nombre, apellido)
VALUES(nextval('personas_id_pers_seq'::regclass), '82743823', 'UY', 'CI', 'Gabriel', 'Diaz');


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

