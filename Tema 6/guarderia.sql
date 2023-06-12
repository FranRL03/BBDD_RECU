DROP TABLE IF EXISTS docentes cascade; 
DROP TABLE IF EXISTS actividades cascade;
DROP TABLE IF EXISTS alumnos cascade;
DROP TABLE IF EXISTS asignacion_act cascade;
DROP TABLE IF EXISTS asistencia_act cascade;

CREATE TABLE docentes(
	dni         varchar(10),
	nombre      varchar(30),
	telefono	varchar(10),
	año_ingreso	date,
	CONSTRAINT pk_docentes PRIMARY KEY (dni)
);

CREATE TABLE actividades(
	id_act		smallserial,
	nombre      varchar(30),
	duracion    NUMERIC,
	CONSTRAINT pk_actividades PRIMARY KEY (id_act)
);

CREATE TABLE alumnos(
	cod_alumnos varchar(10),
	nombre		varchar(30),
	telefono	varchar(10),
	nivel		varchar(10),
	CONSTRAINT pk_alumnos PRIMARY KEY (cod_alumnos)
);

CREATE TABLE asignacion_act(
	id_doc		varchar(10),
	id_act      SMALLINT,
	dia_semana  date,
	hora        timestamp,
	CONSTRAINT pk_asignacion_act PRIMARY KEY (id_doc, id_act, dia_semana, hora)
);

CREATE TABLE asistencia_act(
	id_alumno    varchar(10),
	id_act 		 SMALLINT,
	id_doc		 varchar(10),
	CONSTRAINT pk_asistencia_act PRIMARY KEY (id_alumno, id_act)
);

ALTER TABLE asignacion_act 
	ADD CONSTRAINT fk_docentes_asignacion_act
		FOREIGN KEY (id_doc) REFERENCES docentes,
	ADD CONSTRAINT fk_actividades_asistencias
		FOREIGN KEY (id_act) REFERENCES actividades;
	
ALTER TABLE asistencia_act 
	ADD CONSTRAINT fk_docentes_asistencia_act
		FOREIGN KEY (id_doc) REFERENCES docentes,
	ADD CONSTRAINT fk_asistencia_alumnos
		FOREIGN KEY (id_alumno) REFERENCES alumnos,
	ADD CONSTRAINT fk_actividades_asistencias
		FOREIGN KEY (id_act) REFERENCES actividades;
	

