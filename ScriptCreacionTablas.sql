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
	primary key (matricula, id_peaje, id_bonificacion, fecha_desde)
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


