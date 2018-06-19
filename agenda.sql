-- CONSTRUCTOR

CREATE OR REPLACE FUNCTION contacto (
    IN p_dni                      integer,
    IN p_nombre                   text,
    IN p_apellido                 text,
    IN p_direccion                text,
    IN p_telefono                 text,
    IN p_email                    text
) RETURNS contacto AS
$$
    INSERT INTO agenda
        VALUES (p_dni, p_nombre, p_apellido, p_direccion, p_telefono, p_email)
    RETURNING *;
$$ LANGUAGE sql VOLATILE;

-- DESTRUCTOR

CREATE OR REPLACE FUNCTION eliminar_contacto (
    IN p_contacto                    contacto
) RETURNS void AS
$$
    DELETE FROM agenda c WHERE c = p_contacto;
$$ LANGUAGE sql VOLATILE STRICT;

-- GETTERS

CREATE OR REPLACE FUNCTION contacto_get_dni (
    IN p_contacto                 contacto
) RETURNS integer AS
$$
    SELECT dni(p_contacto);
$$ LANGUAGE sql IMMUTABLE STRICT;


CREATE OR REPLACE FUNCTION contacto_get_nombre (
    IN p_contacto                 contacto
) RETURNS text AS
$$
    SELECT nombre(p_contacto);
$$ LANGUAGE sql IMMUTABLE STRICT;


CREATE OR REPLACE FUNCTION contacto_get_apellido (
    IN p_contacto                 contacto
) RETURNS text AS
$$
    SELECT apellido(p_contacto);
$$ LANGUAGE sql IMMUTABLE STRICT;


CREATE OR REPLACE FUNCTION contacto_get_direccion (
    IN p_contacto                 contacto
) RETURNS text AS
$$
    SELECT direccion(p_contacto);
$$ LANGUAGE sql IMMUTABLE STRICT;


CREATE OR REPLACE FUNCTION contacto_get_telefono (
    IN p_contacto                 contacto
) RETURNS text AS
$$
    SELECT telefono(p_contacto);
$$ LANGUAGE sql IMMUTABLE STRICT;


CREATE OR REPLACE FUNCTION contacto_get_email (
    IN p_contacto                 contacto
) RETURNS text AS
$$
    SELECT email(p_contacto);
$$ LANGUAGE sql IMMUTABLE STRICT;

-- SETTERS

CREATE OR REPLACE FUNCTION contacto_set_direccion (
	IN p_contacto                 contacto,
	IN p_direccion                text
) RETURNS void AS 
$$
	UPDATE agenda c SET direccion = p_direccion WHERE c = p_contacto;
$$ LANGUAGE sql VOLATILE STRICT;


CREATE OR REPLACE FUNCTION contacto_set_telefono (
	IN p_contacto                 contacto,
	IN p_telefono                 text
) RETURNS void AS 
$$
	UPDATE agenda c SET telefono = p_telefono WHERE c = p_contacto;
$$ LANGUAGE sql VOLATILE STRICT;


CREATE OR REPLACE FUNCTION contacto_set_email (
	IN p_contacto                 contacto,
	IN p_email                    text
) RETURNS void AS 
$$
	UPDATE agenda c SET email = p_email WHERE c = p_contacto;
$$ LANGUAGE sql VOLATILE STRICT;

-- IDENTIFICACION

CREATE OR REPLACE FUNCTION contacto_identificar_por_dni (
	IN p_dni                      integer
) RETURNS contacto AS
$$
	SELECT c FROM agenda c WHERE c.dni = p_dni;
$$ LANGUAGE sql STABLE STRICT;

-- BUSQUEDA

CREATE OR REPLACE FUNCTION contacto_buscar (
	IN p_nombre                   text DEFAULT '%',
	IN p_apellido                 text DEFAULT '%'
) RETURNS SETOF contacto AS
$$
	SELECT c FROM agenda c WHERE unaccent(c.nombre) ILIKE unaccent(p_nombre) || '%' 
		AND unaccent(c.apellido) ILIKE unaccent(p_apellido) || '%';
$$ LANGUAGE sql STABLE STRICT;
