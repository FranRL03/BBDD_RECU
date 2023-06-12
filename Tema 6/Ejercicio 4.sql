Bases de Datos
1º DAM
Ejercicio 4
DROP TABLE IF EXISTS usuario;
DROP TABLE IF EXISTS estaciones;
DROP TABLE IF EXISTS bicicletas;
DROP TABLE IF EXISTS uso;

CREATE TABLE usuario (
	dni              varchar(13),
	nombre           varchar NOT NULL,
	apellidos        varchar NOT NULL,
	direccion        varchar,
	telefono         varchar NOT NULL,
	email            varchar NOT NULL,
	passw            varchar (8),
	saldo_disponible NUMERIC NOT NULL DEFAULT 0,
	CONSTRAINT pk_usuario PRIMARY KEY (dni),
	CONSTRAINT passw_min CHECK (passw > '4')
);

CREATE TABLE estaciones(
	cod_estacion     varchar,
	num_estacion     serial,
	direccion        varchar not null,
	latitud          NUMERIC not null,
	longitud         NUMERIC not NULL,
	CONSTRAINT pk_estaciones PRIMARY KEY (cod_estacion)
);

CREATE TABLE bicicletas(
	cod_bicicleta    serial,
	marca            varchar not null,
	modelo           varchar not null,
	fecha_alta       date not null,
	CONSTRAINT pk_bicicletas PRIMARY KEY (cod_bicicleta)
);

CREATE TABLE uso(
	estacion_salida  varchar,
	fecha_salida     timestamp,
	dni_usuario      varchar,
	cod_bicicleta    int,
	estacion_llegada varchar,
	fecha_llegada    timestamp NOT NULL,
	CONSTRAINT pk_uso PRIMARY KEY (estacion_salida, fecha_salida, dni_usuario, cod_bicicleta, estacion_llegada)
);

ALTER TABLE uso 
ADD CONSTRAINT fk_uso_estaciones_salida 
	FOREIGN KEY (estacion_salida) REFERENCES estaciones ON DELETE SET NULL,
ADD CONSTRAINT fk_uso_usuarios
	FOREIGN KEY (dni_usuario) REFERENCES usuario ON DELETE CASCADE,
ADD CONSTRAINT fk_uso_bibicleta
	FOREIGN KEY (cod_bicicleta) REFERENCES bicicletas ON DELETE CASCADE,
ADD CONSTRAINT fk_uso_estaciones_llegada
	FOREIGN KEY (estacion_llegada) REFERENCES estaciones ON DELETE SET NULL;
	
ALTER TABLE usuarios ADD COLUMN fecha_baja date;

ALTER TABLE usuarios DROP COLUMN fecha_baja;