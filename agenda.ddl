--CREAR TABLA

CREATE TABLE agenda (
	dni                           integer PRIMARY KEY,
	nombre                        text NOT NULL,
	apellido                      text NOT NULL,
	direccion                     text,
	telefono                      text,
	email                         text
);
--CREAR INDICE

CREATE INDEX ON agenda(apellido);
