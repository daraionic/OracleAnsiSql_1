
---------- PRACTICA -------------



CREATE TABLE PELICULAS (
    ID_PELICULAS INTEGER,
    ID_DISTRIBUIDOR INTEGER,
    ID_GENERO INTEGER,
    TITULO VARCHAR2(100),
    ID_NACIONALIDAD INTEGER,
    ARGUMENTO VARCHAR2(250)
);

create sequence SEQ_PELICULAS
increment by 1
start with 1;

insert into PELICULAS values (SEQ_PELICULAS.nextval, 1, 4, 'Cadena Perpetua', 1, 'Acusado del asesinato');

select * from PELICULAS;
/
insert into PELICULAS values (SEQ_PELICULAS.nextval, 6, 3, 'El Resplandor', 1, 'Pelicula de terror');
insert into PELICULAS values (SEQ_PELICULAS.nextval, 2, 9, 'El Rey Leon', 1, 'Narra las aventuras');
insert into PELICULAS values (SEQ_PELICULAS.nextval, 4, 1, 'Gangs Of New York', 1, 'Reconstrucción de ');
/

ALTER TABLE PELICULAS
ADD (FOTO integer, FECHA_ESTRENO date, ACTORES varchar2 (250), DIRECTOR varchar2(250), DURACION integer, PRECIO integer);


alter table PELICULAS
add constraint PK_PELICULAS
primary key (ID_DISTRIBUIDOR);


CREATE TABLE DISTRIBUIDORAS (
    ID_DISTRIBUIDOR INTEGER,
    DISTRIBUIDOR VARCHAR2(250),
    DIRECCION VARCHAR2(250),
    EMAIL VARCHAR2(250),
    PAGINA_WEB VARCHAR2(1250),
    TELEFONO INTEGER,
    CONTACTO VARCHAR2(250),
    LOGO VARCHAR2(250));

insert into DISTRIBUIDORAS values (9, '20TH CENTURY FOX', 'C/ Miami Vice, 19', 'sonnycrokett@century.es', 'http://www.fox.es', 9155555555, 'Sonny Crockett', 'century.jpg');
insert into DISTRIBUIDORAS values (1, 'SONY PICTURES', 'C/ iNVASORES, 5', 'mikedonovan@sony.es', 'http://www.sonypictures.es/', 912526546, 'Mike Donovan', 'sonypictures.jpg');
insert into DISTRIBUIDORAS values (2, 'BUENA VISTA INTERNACIONAL', 'C/ Hollywood, 9', 'axelfoley@disney.es', 'http://www.disney.es', 913849400, 'Axel Foley', 'buenavista.jpg');
insert into DISTRIBUIDORAS values (3, 'LAUREN FILMS', 'C/ Isla Tortuga, 205', 'jacksparrow@laurenfilms.es', 'http://www.laurenfilms.es', 932553525, 'Jack Sparrow', 'LaurenFilms.jpg');
insert into DISTRIBUIDORAS values (4, 'TRIPICTURES', 'C/ Conejo Blanco, 6', 'neo@tripictures.es', 'http://www.tripictures-spain.com', 915225252, 'Neo Trinity', 'tripictures.jpg');
insert into DISTRIBUIDORAS values (6, 'MANGA FILMS', 'C/ Halcon Milenario, 67', 'hansolo@mangafilms.es', 'http://www.mangafilms.es', 935464646, 'Han Solo', 'mangafilms.jpg');


/
select * from DISTRIBUIDORAS;

alter table DISTRIBUIDORAS
add constraint PK_DISTRIBUIDORAS
primary key (ID_DISTRIBUIDOR);

alter table PELICULAS
add constraint FK_PELICULAS_DISTRIBUIDORAS
foreign key (ID_DISTRIBUIDOR)
references DISTRIBUIDORAS (ID_DISTRIBUIDOR);


CREATE TABLE GENEROS (
    ID_GENERO INTEGER,
    GENERO VARCHAR2(250));

create sequence SEQ_GENEROS
increment by 1
start with 1;


insert into GENEROS values (SEQ_GENEROS.nextval, 'Accion');
insert into GENEROS values (SEQ_GENEROS.nextval, 'Humor');
insert into GENEROS values (SEQ_GENEROS.nextval, 'Terror');
insert into GENEROS values (SEQ_GENEROS.nextval, 'Drama');
insert into GENEROS values (SEQ_GENEROS.nextval, 'Romantica');
insert into GENEROS values (SEQ_GENEROS.nextval, 'Suspense');
insert into GENEROS values (SEQ_GENEROS.nextval, 'Aventura');
insert into GENEROS values (SEQ_GENEROS.nextval, 'Ciencia Ficcion');
insert into GENEROS values (SEQ_GENEROS.nextval, 'Animacion');
insert into GENEROS values (SEQ_GENEROS.nextval, 'Western');

select * from GENEROS;

alter table GENEROS
add constraint PK_GENERO
primary key (ID_GENERO);

alter table PELICULAS
add constraint FK_PELICULAS_GENEROS
foreign key (ID_GENERO)
references GENEROS (ID_GENERO);


CREATE TABLE NACIONALIDAD (
    ID_NACIONALIDAD INTEGER,
    NACIONALIDAD VARCHAR2(250),
    BANDERA VARCHAR2(250));

create sequence SEQ_NACIONALIDAD
increment by 1
start with 1;

insert into NACIONALIDAD values (SEQ_NACIONALIDAD.nextval, 'EEUU', 'EEUU.jpg');
insert into NACIONALIDAD values (SEQ_NACIONALIDAD.nextval, 'ESPAÑA', 'ES.jpg');
insert into NACIONALIDAD values (SEQ_NACIONALIDAD.nextval, 'ALEMANIA', 'ALEMANIA.jpg');
insert into NACIONALIDAD values (SEQ_NACIONALIDAD.nextval, 'REINO UNIDO', 'UK.jpg');
insert into NACIONALIDAD values (SEQ_NACIONALIDAD.nextval, 'CANADA', 'CAN.jpg');
insert into NACIONALIDAD values (SEQ_NACIONALIDAD.nextval, 'ITALIA', 'IT.jpg');

alter table NACIONALIDAD
add constraint PK_NACIONALIDAD
primary key (ID_NACIONALIDAD);

alter table PELICULAS
add constraint FK_PELICULAS_NACIONALIDAD
foreign key (ID_NACIONALIDAD)
references NACIONALIDAD (ID_NACIONALIDAD);


CREATE TABLE PEDIDOS (
    ID_PEDIDO INTEGER,
    ID_CLIENTE INTEGER,
    ID_PELICULA INTEGER,
    CANTIDAD INTEGER,
    FECHA DATE,
    PRECIO INTEGER);

insert into PEDIDOS values (, 'EEUU', 'EEUU.jpg');

create sequence SEQ_PEDIDOS
increment by 1
start with 1;

insert into PEDIDOS values (SEQ_PEDIDOS.nextval, 1, 2, 1, TO_DATE('19/02/2007', 'DD/MM/YYYY'), 16);
insert into PEDIDOS values (SEQ_PEDIDOS.nextval, 1, 15, 2, TO_DATE('24/02/2005', 'DD/MM/YYYY'), 32);
insert into PEDIDOS values (SEQ_PEDIDOS.nextval, 1, 19, 2, TO_DATE('24/07/2008', 'DD/MM/YYYY'), 48);
insert into PEDIDOS values (SEQ_PEDIDOS.nextval, 1, 32, 1, TO_DATE('18/08/2006', 'DD/MM/YYYY'), 25);
insert into PEDIDOS values (SEQ_PEDIDOS.nextval, 1, 33, 2, TO_DATE('19/08/2006', 'DD/MM/YYYY'), 36);
insert into PEDIDOS values (SEQ_PEDIDOS.nextval, 1, 1, 1, TO_DATE('22/01/2005', 'DD/MM/YYYY'), 14);
insert into PEDIDOS values (SEQ_PEDIDOS.nextval, 1, 3, 2, TO_DATE('06/05/2005', 'DD/MM/YYYY'), 30);
insert into PEDIDOS values (SEQ_PEDIDOS.nextval, 1, 4, 4, TO_DATE('20/03/2007', 'DD/MM/YYYY'), 84);


alter table PEDIDOS
add constraint PK_PEDIDOS
primary key (ID_PELICULA);

ALTER TABLE PELICULAS
RENAME COLUMN ID_PELICULAS TO ID_PELICULA;

alter table PELICULAS
add constraint FK_PELICULAS_PEDIDOS
foreign key (ID_PELICULA)
references PEDIDOS (ID_PELICULA);


CREATE TABLE CLIENTES (
    ID_CLIENTE INTEGER,
    NOMBRE VARCHAR2(250),
    DIRECCION VARCHAR2(250),
    EMAIL VARCHAR2(250),
    CPOSTAL INTEGER,
    PAGINA_WEB VARCHAR2(250),
    IMAGEN_CLIENTE VARCHAR2(250));

create sequence SEQ_CLIENTES
increment by 1
start with 1;

select * from CLIENTES;

insert into CLIENTES values (SEQ_CLIENTES.nextval, 'DELORIAN', 'C/ Paseo Castellana, 150', 'blockbuster@video.es', 28020, 'http://www.delorian.es', 'delorian.jpg');



alter table CLIENTES
add constraint PK_CLIENTES
primary key (ID_CLIENTE);


alter table PEDIDOS
add constraint FK_PEDIDOS_CLIENTES
foreign key (ID_CLIENTE)
references CLIENTES (ID_CLIENTE);


3)

create or replace procedure sp_insertarcliente
(p_ID_CLIENTE CLIENTES.ID_CLIENTE%TYPE,
p_NOMBRE CLIENTES.NOMBRE%TYPE,
p_DIRECCION CLIENTES.DIRECCION%TYPE,
p_EMAIL CLIENTES.EMAIL%TYPE,
p_CPOSTAL CLIENTES.CPOSTAL%TYPE,
p_PAGINA_WEB CLIENTES.PAGINA_WEB%TYPE,
p_IMAGEN_CLIENTE CLIENTES.IMAGEN_CLIENTE%TYPE)
as
begin
    insert into CLIENTES values (p_ID_CLIENTE, p_NOMBRE, p_DIRECCION, p_EMAIL, p_CPOSTAL, 
    p_PAGINA_WEB, p_IMAGEN_CLIENTE);
end;

select * from clientes;

begin
    sp_insertarcliente(SEQ_CLIENTES.nextval, 'RICARDO TUBBS', 'C/ Islas Canarias, 19', 'miamivice@video.es', 28020, 'http://www.ricardotubss.es', 'tubbs.jpg');
    commit;
end;

delete from CLIENTES where ID_CLIENTE = 3;

4)

update PELICULAS set PRECIO = 21 where ID_PELICULA = 4;

select * from PELICULAS

create or replace procedure sp_preciopelicula 
(p_idPelicula IN PELICULAS.ID_PELICULA%TYPE, p_precio OUT PELICULAS.PRECIO%TYPE)
as
    v_precio PELICULAS.PRECIO%TYPE;
BEGIN
    SELECT PRECIO INTO v_precio FROM PELICULAS
    WHERE ID_PELICULA = p_idPelicula;
    p_precio := v_precio;
    dbms_output.put_line ('El costo de la pelicula es de ' || v_precio );
end;


create or replace procedure sp_preciopelicula 
(p_idPelicula IN PELICULAS.ID_PELICULA%TYPE)
as
    v_precio PELICULAS.PRECIO%TYPE;
BEGIN
    SELECT PRECIO INTO v_precio FROM PELICULAS
    WHERE ID_PELICULA = p_idPelicula;
    dbms_output.put_line ('El costo de la pelicula es de ' || v_precio );
end;


begin
    sp_preciopelicula (2);
end;

SELECT * FROM PELICULAS WHERE ID_PELICULA = 1;



5) 
SELECT * FROM CLIENTES;

create or replace procedure sp_cambiar_datos_cliente
(p_nombre CLIENTES.NOMBRE%TYPE, p_email CLIENTES.EMAIL%TYPE, p_direccion CLIENTES.DIRECCION%TYPE)
as
begin
    update CLIENTES set EMAIL = p_email, DIRECCION = p_direccion where upper (NOMBRE) = upper (p_nombre);
    dbms_output.put_line ('Se ha cambiado en el cliente ' || p_nombre || ' su mail a ' || p_email || 'y su dirección a ' || p_direccion);
end;


begin
    sp_cambiar_datos_cliente ('DELORIAN', '1234@gmail.com', 'Athos, 31');
end;


6) 
select * from DISTRIBUIDORAS;

create or replace function f_DISTRIBUIDORAS
(p_nombre DISTRIBUIDORAS.DISTRIBUIDOR%TYPE)
return number
as
    v_tel number;
begin
    select TELEFONO into v_tel FROM DISTRIBUIDORAS where UPPER(DISTRIBUIDOR)=UPPER(p_nombre);
    return v_tel;
end;

select f_DISTRIBUIDORAS ('SONY PICTURES') as TEL from DUAL;


7) 

update PELICULAS set DURACION = 87 where ID_PELICULA = 3;

select * from peliculas;

create or replace function f_DURACION_PELICULAS
(p_titulo PELICULAS.TITULO%TYPE)
return number
as
    v_duracion number;
begin
    select DURACION into v_duracion FROM PELICULAS where UPPER(TITULO)=UPPER(p_titulo);
    return v_duracion;
end;


select f_DURACION_PELICULAS ('Cadena Perpetua') as DURACION from DUAL;


8)

SELECT * FROM CLIENTES;

SELECT * FROM PEDIDOS;

create or replace procedure sp_importe_total_cliente
(p_idCliente IN CLIENTES.ID_CLIENTE%TYPE)
as
    v_importeTotal PEDIDOS.PRECIO%TYPE;
BEGIN
    SELECT SUM (PRECIO) into v_importeTotal from PEDIDOS where ID_CLIENTE = p_idCliente;
    dbms_output.put_line ('El importe total para el cliente ' || p_idCliente || ' es: ' || v_importeTotal);
end;

SELECT SUM (PRECIO) from PEDIDOS where ID_CLIENTE = 1;

BEGIN
    sp_importe_total_cliente(1);
END;

----
ok

create or replace procedure sp_total_pedidos_clientes 
    (p_idCliente PEDIDOS.ID_CLIENTE%TYPE, 
    p_total OUT number)
as
begin
    select sum(PRECIO) into p_total from PEDIDOS where ID_CLIENTE = p_idCliente;
    dbms_output.put_line ('El importe total para el cliente ' || p_idCliente || ': ' || p_total);
end;

DECLARE
    v_total NUMBER;
BEGIN
    sp_total_pedidos_clientes(1, v_total);
END;


9) 

CREATE OR REPLACE PROCEDURE sp_datos_nacionalidad (p_idNacionalidad IN NACIONALIDAD.ID_NACIONALIDAD%TYPE) 
AS
    v_nombre NACIONALIDAD.NACIONALIDAD%TYPE;
    v_bandera NACIONALIDAD.BANDERA%TYPE;
BEGIN
    SELECT NACIONALIDAD, BANDERA
    INTO v_nombre, v_bandera
    FROM NACIONALIDAD
    WHERE ID_NACIONALIDAD = p_idNacionalidad;

    -- Mostrar datos (opcional)
    DBMS_OUTPUT.PUT_LINE('Nacionalidad: ' || v_nombre || ', Bandera: ' || v_bandera);
END sp_datos_nacionalidad;


BEGIN
    sp_datos_nacionalidad(1);
END;

------------

CREATE OR REPLACE PROCEDURE sp_recuperar_nacionalidad_bandera (
    p_idNacionalidad NACIONALIDAD.ID_NACIONALIDAD%TYPE, 
    p_nacionalidad OUT NACIONALIDAD.NACIONALIDAD%TYPE, 
    p_bandera OUT NACIONALIDAD.BANDERA%TYPE)
AS
BEGIN
    SELECT NACIONALIDAD, BANDERA 
    INTO p_nacionalidad, p_bandera
    FROM NACIONALIDAD
    WHERE ID_NACIONALIDAD = p_idNacionalidad;
    DBMS_OUTPUT.PUT_LINE('La nacionalidad es: ' || p_nacionalidad || ' La bandera es: ' || p_bandera);
END;

DECLARE
    v_nacionalidad NACIONALIDAD.NACIONALIDAD%TYPE;
    v_bandera NACIONALIDAD.BANDERA%TYPE;
BEGIN
    sp_recuperar_nacionalidad_bandera(1, v_nacionalidad, v_bandera);
END;

10) 

create or replace procedure sp_info_peliculas (p_idPelicula PELICULAS.ID_PELICULA%TYPE)
as
    type type_peliculas is record (
        v_titulo PELICULAS.TITULO%TYPE,
        v_duracion PELICULAS.DURACION%TYPE,
        v_precio PELICULAS.PRECIO%TYPE
    );
        v_info_pelicula type_peliculas;
begin
    select TITULO, DURACION, PRECIO into v_info_pelicula
    from PELICULAS where ID_PELICULA = p_idPelicula;
    dbms_output.put_line ('Titulo: ' || v_info_pelicula.v_titulo 
    || ', Duración: ' || v_info_pelicula.v_duracion 
    || ', Precio: ' || v_info_pelicula.v_precio);
end;

BEGIN
    sp_info_peliculas(1);
END;

11)
SET SERVEROUTPUT ON;


select * from CLIENTES;

create or replace procedure sp_info_clientes (p_idCliente CLIENTES.ID_CLIENTE%TYPE)
as
    v_cliente CLIENTES%ROWTYPE;
begin
    select * into v_cliente from CLIENTES where ID_CLIENTE = p_idCliente;
    dbms_output.put_line ('ID: ' || v_cliente.ID_CLIENTE
    || ', Nombre: ' || v_cliente.NOMBRE 
    || ', Dirección: ' || v_cliente.DIRECCION 
    || ', Email: ' || v_cliente.EMAIL 
    || ', Código Postal: ' || v_cliente.CPOSTAL 
    || ', Página web: ' || v_cliente.PAGINA_WEB 
    || ', Imagen del Cliente: ' || v_cliente.IMAGEN_CLIENTE);
EXCEPTION
    when NO_DATA_FOUND then
    dbms_output.put_line ('No existe un cliente con el ID ' || p_idCliente);
end;

BEGIN
    sp_info_clientes(99);
END;


12)

CREATE OR REPLACE PROCEDURE sp_precio_pelicula (
    p_precio PELICULAS.PRECIO%TYPE
)
AS
    v_precio PELICULAS.PRECIO%TYPE;
BEGIN
    SELECT PRECIO
    INTO v_precio
    FROM PELICULAS
    WHERE ID_PELICULA = p_id_y_precio;

    -- Devuelve el precio en el mismo parámetro
    p_id_y_precio := v_precio;

    DBMS_OUTPUT.PUT_LINE('El precio de la película es: ' || v_precio);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró la película con ese ID');
        p_id_y_precio := NULL;
END;
/

-----------

CREATE OR REPLACE PROCEDURE sp_obtener_precio_pelicula (
    p_idPelicula PELICULAS.ID_PELICULA%TYPE, 
    p_precio OUT PELICULAS.PRECIO%TYPE)
AS
BEGIN
    SELECT PRECIO
    INTO p_precio
    FROM PELICULAS
    WHERE ID_PELICULA = p_idPelicula;
    DBMS_OUTPUT.PUT_LINE('El precio de la película con ID ' || p_idPelicula || ' es: ' || p_precio);
END;

DECLARE
    v_precio PELICULAS.PRECIO%TYPE;
BEGIN
    sp_obtener_precio_pelicula(1, v_precio);
END;


13) 

declare
    type type_distribuidor is record (
        v_email DISTRIBUIDORAS.EMAIL%TYPE,
        v_pagina_web DISTRIBUIDORAS.PAGINA_WEB%TYPE,
        V_telefono DISTRIBUIDORAS.TELEFONO%TYPE);
    v_tipo_distribuidor type_distribuidor;
begin
    select EMAIL, PAGINA_WEB, TELEFONO into v_tipo_distribuidor
    from DISTRIBUIDORAS where ID_DISTRIBUIDOR = 1;
    dbms_output.put_line ('Email: ' || v_tipo_distribuidor.v_email || 
    ', Página Web: ' || v_tipo_distribuidor.v_pagina_web || 
    ', Teléfono: ' || v_tipo_distribuidor.v_telefono);
end;


14) 

-- Guardar en un Varray el título de las películas cuyo género sea acción (o el género que tengáis insertado). 

????

15) 

-- Declarar una variable de tipo tabla y guardar los números pares del 1 al 200. Imprimir los valores en pantalla.

DECLARE
    TYPE t_numeros_pares IS TABLE OF NUMBER;
    v_numeros_pares t_numeros_pares := t_numeros_pares();
BEGIN
    FOR i IN 1..200 LOOP
        IF MOD(i, 2) = 0 THEN
            v_numeros_pares.EXTEND;
            v_numeros_pares(v_numeros_pares.LAST) := i;
        END IF;
    END LOOP;
    FOR i IN 1..v_numeros_pares.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Número par: ' || v_numeros_pares(i));
    END LOOP;
END;


16) 

-- Crear un procedimiento almacenado que devuelva un ROWTYPE de género pasando como parámetro de entrada el idGenero.

select * from GENEROS;

CREATE OR REPLACE PROCEDURE sp_devuelve_genero (
    p_idGenero GENEROS.ID_GENERO%TYPE,
    p_genero OUT GENEROS%ROWTYPE
)
AS
BEGIN
    SELECT * INTO p_genero
    FROM GENEROS
    WHERE ID_GENERO = p_idGenero;
    DBMS_OUTPUT.PUT_LINE('ID Genero: ' || p_genero.ID_GENERO || ', Nombre Genero: ' || p_genero.GENERO);
end;

DECLARE
    v_genero GENEROS%ROWTYPE;
BEGIN
    sp_devuelve_genero(4, v_genero);
end;

17)

-- Usar una sentencia case dentro de un procedimiento almacenado para que nos devuelva de la tabla distribuidoras:

-- SP si el nombre es SONY PICTURES.
-- BVI si es BUENA VISTA INTERNACIONAL
-- LF si es  LAUREN FILMS.                                       
-- WB si es WARNER BROTHERS.
-- TP si es TRIPICTURES.

-- El procedimiento almacenado tendrá un parámetro de entrada (IdDistribuidor) y nos devolverá el nombre del distribuidor.

CREATE OR REPLACE PROCEDURE sp_codigo_distribuidor (
    p_idDistribuidor DISTRIBUIDORAS.ID_DISTRIBUIDOR%TYPE,
    p_codigo OUT VARCHAR2
)
AS
BEGIN
    SELECT 
        CASE 
            WHEN UPPER(DISTRIBUIDOR) = 'SONY PICTURES' THEN 'SP'
            WHEN UPPER(DISTRIBUIDOR) = 'BUENA VISTA INTERNACIONAL' THEN 'BVI'
            WHEN UPPER(DISTRIBUIDOR) = 'LAUREN FILMS' THEN 'LF'
            WHEN UPPER(DISTRIBUIDOR) = 'WARNER BROTHERS' THEN 'WB'
            WHEN UPPER(DISTRIBUIDOR) = 'TRIPICTURES' THEN 'TP'
        END
    INTO p_codigo
    FROM DISTRIBUIDORAS
    WHERE ID_DISTRIBUIDOR = p_idDistribuidor;
    DBMS_OUTPUT.PUT_LINE('Código del distribuidor: ' || p_codigo);
END;

DECLARE
    v_codigo VARCHAR2(10);
BEGIN
    sp_codigo_distribuidor(1, v_codigo);
END;