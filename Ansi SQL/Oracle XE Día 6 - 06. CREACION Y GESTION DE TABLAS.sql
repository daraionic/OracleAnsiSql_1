--------- CREAR TABLAS


create table PRUEBA (
    IDENTIFICADOR integer, 
    TEXTO10 varchar2(10),
    TEXTOCHAR char(5));
    

describe PRUEBA;


insert into PRUEBA values (1, 'abcdesdfgh', 'aeiou');

insert into PRUEBA values (1, 'A', 'A');



select * from PRUEBA;

-- Con rollback se eliminan los datos pero nunca nunca nunca la tabla.
-- drop table sirve para eliminar una tabla. No hay vuela atras.

;
drop table PRUEBA;


create table PRUEBA (
    IDENTIFICADOR integer, 
    TEXTO10 varchar2(10),
    TEXTOCHAR char(5));
    
insert into PRUEBA values (1, 'abcdesdfgh', 'aeiou');

-- La tabla prueba contiene un registro. Agregamos una nueva columna de tipo 
--texto llamada nueva.
;
alter table PRUEBA
add (NUEVA varchar2(3));

-- Agregamos otra columna de tipo texto llamada SINNULOS y no admitira NULOS.

alter table PRUEBA
add (SINNULOS varchar2(7) not null);

rollback;

-- No podemos agregar una nueva columna NOT NULL si es que ya existen registros 
--dentro de la tabla porque le pondria NULL a esa columna que estoy creando como
--NOT NULL
;
delete from PRUEBA;

select * from PRUEBA;

-- SI USAMOS alter table TABLA drop column COLUMNA eliminará la columna con
--todos lo datos que tenga dentro.

alter table PRUEBA
drop column SINNULOS;

-- Para modificar el tipo de dato de una columna en una tabla se utiliza la 
--instrucción ALTER TABLE. 

--Sintaxis:  

    ALTER TABLE 
    MODIFY (NB_COLUMNA TIPO_DATO [dafault expresión],...); 

;
describe PRUEBA;

alter table PRUEBA
modify (NUEVA float);


-- CAMBIO DE NOMBRE DE UNA TABLA RENAME 

-- Sintaxis. 	RENAME OLD_NAME TO NEXT_NAME; 

-- Ejemplo: Renombremos la tabla fecha a fechaNueva 

rename PRUEBA to  PRUEVA; 

rename PRUEVA to PRUEBA;

-- Esta  instrucción realiza COMMIT automático.  




-- TRUNCADO DE UNA TABLA.  TRUNCATE  

-- Borra los registros de la tabla y libera el espacio de almacenamiento ocupado 
--por ella.  Realiza COMMIT automático. 

  
-- Sintaxis: 	TRUNCATE TABLE NB_TABLA; 

-- Ejemplo: Truncar la tabla fechanueva: 

TRUNCATE TABLE PRUEBA; 


-- A diferencia de DELETE, TRUNCATE elimina todas las filas de la tabla sin 
--borrar la tabla. También resetea los contadores de auto incremento a 0.

-- No borra la tabla como tal, la llamada estructura, por lo que luego puede 
--comenzar a hacer inserciones.



------ AÑADIR Y ELIMINAR COMENTARIOS A UNA TABLA. COMMENT 

Sintaxis:  	COMMENT ON TABLE NB_TABLA IS ‘ TEXTO’;  

EJEMPLO:  

Añadir un comentario a la tabla PRUEBA 

comment on table PRUEBA
is 'Hoy es miercoles y mañan jueves';

select * from PRUEBA;

 
-- Se pueden ver en el diccionario de datos en las siguientes tablas:  

ALL_COL_COMMENTS  

USER_COL_COMMENTS  

ALL_TAB_COMMENTS   

USER_TAB_COMMENTS 

Ejemplo: Visualizar  los comentarios de la tabla PRUEBA. 

select * from USER_TAB_COMMENTS where TABLE_NAME = 'PRUEBA';

select * from ALL_TAB_COMMENTS where TABLE_NAME = 'PRUEBA';



--- CONSULTAS AL DICCIONARIO DE DATOS 


-- Para describir las tablas que son propiedad del usuario, haremos: 

 
select * from USER_TABLES;

select * from ALL_TABLES;

-- Para ver los distintos tipos de objetos  propiedad del usuario: 

SELECT DISTINCT OBJECT_TYPE  FROM  USER_OBJECTS; 


-- Para ver los  objetos que son propiedad del usuario:  

SELECT  *  FROM  CAT; 





------ SINTAXIS CREACION DE OBJETOS EN ORACLE:


-- PRIMARY KEY: SOLO UNA POR TABLA, No admiten datos null en la columna y no 
--podremos tener registros repetidos. 


-- UNIQUE: Es exactamente igual a Primary Key.  No permite repetidos, se realiza 
--sobre campos not null. 

La gran diferencia es que podemos tener varios campos como Unique dentro de una 
--misma tabla. 

Un campo Unique podría afectar a más de una columna. 


-- FOREIGN KEY: Es una restricción que relaciona uno o varios campos entre 
--tablas.

-- Evitan que existan resultados no relacionales entre las tablas. 

-- Puede contener nulos.



-- CHECK: Evalúa un campo sobre un valor o valores constantes e impide la 
--modificación o la inserción de dicho valor en la tabla si no cumple nuestra 
--condición. 




    describe PRUEBA;


select * from PRUEBA;

-- AÑADIMOS UNA COLUMA LLAMADA TEST

alter table PRUEBA
add (test int);

-- AÑADIMOS OTRA COLUMNA, PERO QUE CONTENDRÁ VALORES POR DEFECTO

alter table PRUEBA
add (DEFECTO int default -1);

insert into PRUEBA (identificador, texto10, textochar)
values (2, 'AA', 'AA');

insert into PRUEBA (identificador, texto10, textochar, defecto)
values (3, 'BB', 'BB', 22);

insert into PRUEBA (identificador, texto10, textochar, defecto)
values (4, 'CC', 'CC', null);

drop table PRUEBA;


----------------------------------------


DROP TABLE DEPT;
DROP TABLE EMP;
DROP TABLE HOSPITAL;
DROP TABLE SALA;
DROP TABLE DOCTOR;
DROP TABLE PLANTILLA;
DROP TABLE ENFERMO;
DROP TABLE OCUPACION;

CREATE TABLE DEPT
  (DEPT_NO NUMBER(9)
  ,DNOMBRE VARCHAR2(50)
  ,LOC VARCHAR2(50)
);

CREATE TABLE EMP
  (EMP_NO NUMBER(9)
  ,APELLIDO VARCHAR2(50)
  ,OFICIO VARCHAR2(50)
  ,DIR NUMBER(9)
  ,FECHA_ALT DATE
  ,SALARIO NUMBER(9)
  ,COMISION NUMBER(9)
  ,DEPT_NO NUMBER(9)
);

CREATE TABLE HOSPITAL(
  HOSPITAL_COD NUMBER(9)
  ,NOMBRE VARCHAR2(50)
  ,DIRECCION VARCHAR2(100),
  TELEFONO VARCHAR2(9),
  NUM_CAMA NUMBER(9)
);

CREATE TABLE SALA(
  HOSPITAL_COD NUMBER(9)
  ,SALA_COD NUMBER(9)
  ,NOMBRE VARCHAR2(60)
  ,NUM_CAMA NUMBER(9)
);

CREATE TABLE DOCTOR(
  HOSPITAL_COD NUMBER(9)
  ,DOCTOR_NO NUMBER(9)
  ,APELLIDO VARCHAR2(60)
  ,ESPECIALIDAD VARCHAR2(60),
  SALARIO NUMBER(9)
);

CREATE TABLE PLANTILLA(
  HOSPITAL_COD NUMBER(9)
  ,SALA_COD NUMBER(9)
  ,EMPLEADO_NO NUMBER(9)
  ,APELLIDO VARCHAR2(60)
  ,FUNCION VARCHAR2(60)
  ,TURNO VARCHAR2(1)
  ,SALARIO NUMBER(9)
);

CREATE TABLE ENFERMO(
  INSCRIPCION NUMBER(9)
  ,APELLIDO VARCHAR2(60)
  ,DIRECCION VARCHAR2(100)
  ,FECHA_NAC DATE
  ,SEXO VARCHAR2(1)
  ,NSS NUMBER(9)
);

CREATE TABLE OCUPACION(
  INSCRIPCION NUMBER(9)
  ,HOSPITAL_COD NUMBER(9)
  ,SALA_COD NUMBER(9)
  ,CAMA NUMBER(9)
);

insert into hospital values(19,'provincial','o donell 50','964-4264',502);
insert into hospital values(18,'general','Atocha s/n','595-3111',987);
insert into hospital values(22,'la paz','castellana 1000','923-5411',412);
insert into hospital values(45,'san carlos','ciudad universitaria','597-1500',845);
insert into hospital values(17,'ruber','juan bravo 49','914027100',217);
/
insert into sala values(19,3,'cuidados intensivos',21);
insert into sala values(19,6,'psiquiatria',67);
insert into sala values(18,3,'cuidados intensivos',10);
insert into sala values(18,4,'cardiologia',53);
insert into sala values(22,1,'recuperacion',10);
insert into sala values(22,6,'psiquiatria',118);
insert into sala values(22,2,'maternidad',34);
insert into sala values(45,4,'cardiologia',55);
insert into sala values(45,1,'recuperacion',17);
insert into sala values(45,2,'maternidad',24);
insert into sala values(17,2,'maternidad',19);
insert into sala values(17,6,'psiquiatria',20);
insert into sala values(17,3,'cuidados intensivos',21);
/
insert into plantilla values(19,6,3754,'diaz b.','ENFERMERO','T',226200);
insert into plantilla values(19,6,3106,'hernandez j.','ENFERMERO','T',275500);
insert into plantilla values(18,4,6357,'karplus w.','INTERINO','T',337900);
insert into plantilla values(22,6,1009,'higueras d.','ENFERMERA','T',200500);
insert into plantilla values(22,6,8422,'bocina g.','ENFERMERO','M',163800);
insert into plantilla values(22,2,9901,'nuñez c.','INTERINO','M',221000);
insert into plantilla values(22,1,6065,'rivera g.','ENFERMERA','N',162600);
insert into plantilla values(22,1,7379,'carlos r.','ENFERMERA','T',211900);
insert into plantilla values(45,4,1280,'amigo r.','INTERINO','N',221000);
insert into plantilla values(45,1,8526,'frank h.','ENFERMERO','T',252200);
insert into plantilla values(17,2,8519,'chuko c.','ENFERMERO','T',252200);
insert into plantilla values(17,6,8520,'palomo c.','INTERINO','M',219210);
insert into plantilla values(17,6,8521,'cortes v.','ENFERMERA','N',221200);

/
insert into doctor values(19,435,'Lopez A.','Cardiologia',350000);
insert into doctor values(18,585,'Miller G.','Ginecologia',250000);
insert into doctor values(18,982,'Cajal R','Cardiologia',290000);
insert into doctor values(22,453,'Galo C.','Pediatria',250000);
insert into doctor values(22,398,'Best K.','Urologia',150000);
insert into doctor values(22,386,'Cabeza D.','Psiquiatria',125000);
insert into doctor values(45,607,'Niqo P.','Pediatria',240000);
insert into doctor values(45,522,'Adams C.','Neurologia',450000);
insert into doctor values(17,521,'Nino P.','Neurologia',390000);
insert into doctor values(17,120,'Curro F.','Urologia',250000);
/
INSERT INTO ENFERMO VALUES(10995, 'Languia M.', 'Goya 20', TO_DATE('16-05-1956', 'DD-MM-YYYY'), 'M', 280862482);
INSERT INTO ENFERMO VALUES(18004, 'Serrano V.', 'Alcala 12', TO_DATE('21-05-1960', 'DD-MM-YYYY'), 'F', 284991452);
INSERT INTO ENFERMO VALUES(14024, 'Fernandez N.', 'Recoletos 5', TO_DATE('23-07-1967', 'DD-MM-YYYY'), 'F', 321790059);
INSERT INTO ENFERMO VALUES(36658, 'Domin S.', 'Mayor 71', TO_DATE('01-01-1942', 'DD-MM-YYYY'), 'M', 160657471);
INSERT INTO ENFERMO VALUES(38702, 'Neal R.', 'Orense 21', TO_DATE('18-07-1940', 'DD-MM-YYYY'), 'F', 380010217);
INSERT INTO ENFERMO VALUES(39217, 'Cervantes M.', 'Perón 38', TO_DATE('29-02-1952', 'DD-MM-YYYY'), 'M', 440294390);
INSERT INTO ENFERMO VALUES(59076, 'Miller G.', 'Lopez de Hoyos 2', TO_DATE('16-09-1945', 'DD-MM-YYYY'), 'F', 311969044);
INSERT INTO ENFERMO VALUES(63827, 'Ruiz P.', 'Esquerdo 103', TO_DATE('26-12-1980', 'DD-MM-YYYY'), 'M', 200973253);
INSERT INTO ENFERMO VALUES(64882, 'Fraser A.', 'Soto 3', TO_DATE('10-07-1980', 'DD-MM-YYYY'), 'F', 285201776);
INSERT INTO ENFERMO VALUES(74835, 'Benitez E.', 'Argentina 5', TO_DATE('05-10-1956', 'DD-MM-YYYY'), 'M', 154811767);
/
INSERT INTO OCUPACION VALUES(10995,19,6,1);
INSERT INTO OCUPACION VALUES(18004,19,3,2);
INSERT INTO OCUPACION VALUES(14024,19,6,3);
INSERT INTO OCUPACION VALUES(36658,18,4,1);
INSERT INTO OCUPACION VALUES(38702,18,4,2);
INSERT INTO OCUPACION VALUES(39217,22,1,1);
INSERT INTO OCUPACION VALUES(59076,22,6,2);
INSERT INTO OCUPACION VALUES(63827,22,6,3);
INSERT INTO OCUPACION VALUES(64882,22,2,1);
/
insert into dept values(10,'CONTABILIDAD','SEVILLA');
insert into dept values(20,'INVESTIGACIÓN','MADRID');
insert into dept values(30,'VENTAS','BARCELONA');
insert into dept values(40,'PRODUCCIÓN','GRANADA');
/
INSERT INTO emp VALUES('7839', 'rey', 'PRESIDENTE', NULL, TO_DATE('17-11-2005', 'DD-MM-YYYY'), 650000, NULL, 10);
INSERT INTO emp VALUES('7698', 'negro', 'DIRECTOR', 7839, TO_DATE('01-05-2005', 'DD-MM-YYYY'), 370500, 0, 30);
INSERT INTO emp VALUES('7566', 'jimenez', 'DIRECTOR', 7839, TO_DATE('02-04-2005', 'DD-MM-YYYY'), 386750, 0, 20);
INSERT INTO emp VALUES('7782', 'cerezo', 'DIRECTOR', 7839, TO_DATE('09-06-2005', 'DD-MM-YYYY'), 318500, 0, 10);
INSERT INTO emp VALUES('7499', 'arroyo', 'VENDEDOR', 7698, TO_DATE('20-02-2004', 'DD-MM-YYYY'), 208000, 39000, 30);
INSERT INTO emp VALUES('7521', 'sala', 'VENDEDOR', 7698, TO_DATE('22-02-2005', 'DD-MM-YYYY'), 162500, 65000, 30);
INSERT INTO emp VALUES('7654', 'martin', 'VENDEDOR', 7698, TO_DATE('29-07-2005', 'DD-MM-YYYY'), 162500, 182000, 30);
INSERT INTO emp VALUES('7844', 'tovar', 'VENDEDOR', 7698, TO_DATE('08-07-2005', 'DD-MM-YYYY'), 195000, 0, 30);
INSERT INTO emp VALUES('7900', 'jimeno', 'EMPLEADO', 7698, TO_DATE('03-12-2005', 'DD-MM-YYYY'), 123500, 0, 30);
INSERT INTO emp VALUES('7902', 'fernandez', 'ANALISTA', 7566, TO_DATE('03-12-2007', 'DD-MM-YYYY'), 390000, 0, 20);
INSERT INTO emp VALUES('7788', 'gil', 'ANALISTA', 7566, TO_DATE('09-11-2008', 'DD-MM-YYYY'), 390000, 0, 20);
INSERT INTO emp VALUES('7369', 'sanchez', 'EMPLEADO', 7902, TO_DATE('17-12-2004', 'DD-MM-YYYY'), 104000, 0, 20);
INSERT INTO emp VALUES('7876', 'alonso', 'EMPLEADO', 7788, TO_DATE('23-07-2005', 'DD-MM-YYYY'), 143000, 0, 20);
INSERT INTO emp VALUES('7934', 'muñoz', 'EMPLEADO', 7782, TO_DATE('23-01-2006', 'DD-MM-YYYY'), 169000, 0, 10);
INSERT INTO emp VALUES('7919', 'serra', 'DIRECTOR', 7839, TO_DATE('11-12-2008', 'DD-MM-YYYY'), 395000, 0, 20);
INSERT INTO emp VALUES('7907', 'campayo', 'ANALISTA', 7919, TO_DATE('04-06-2009', 'DD-MM-YYYY'), 251000, 25000, 20);
INSERT INTO emp VALUES('7917', 'nino', 'VENDEDOR', 7919, TO_DATE('06-02-2004', 'DD-MM-YYYY'), 171000, 0, 20);
INSERT INTO emp VALUES('7904', 'ford', 'EMPLEADO', 7907, TO_DATE('04-04-2004', 'DD-MM-YYYY'), 162500, 0, 20);
INSERT INTO emp VALUES('7914', 'gutierrez', 'ANALISTA', 7919, TO_DATE('20-10-2006', 'DD-MM-YYYY'), 258500, 50000, 20);
commit;


---------------------


-- INCLUIR UNA RESTRICCION PRIMARY KEY EN EL CAMPO DEPT_NO DE DEPARTAMENTOS PARA
--QUE NO PUEDA INCLUIR NULOS.

;
alter table DEPT
add constraint PK_DEPT
primary key (DEPT_NO);

-- TODAS LAS RESTRICCIONES DEL USUARIO SE ENCUENTRAN EN LO QUE SE LLAMA EN EL
--DICCIONARIO USER_CONSTRAINTS

select * from USER_CONSTRAINTS;

-- INTENTAMOS INSERTAR UN DEPARTAMENTO REPETIDO

insert into DEPT values (10, 'REPE', 'REPE');

select * from DEPT;


--- ELIMINAMOS LA RESTRICCION DE PRIMARY KEY DE DEPARTAMENTOS

alter table DEPT
drop constraint PK_DEPT;

delete from DEPT where DEPT_NO=10;

commit;


-----------------

-- CREAMOS UNA PRIMARY KEY PARA EL CAMPO EMP_NO

alter table EMP
add constraint PK_EMP
primary key (EMP_NO);

select * from EMP;

-- CREAMOS UNA RESTICCION PARA COMPROBAR QUE EL SALARIO SIEMPRE SEA POSITIVO:
-- CH_TABLA_CAMPO

alter table EMP
add constraint CH_EMP_SALARIO
check (SALARIO >= 0);

-- PONEMOS UN VALOR NEGATIVO A UN EMPLEADO:

update EMP set SALARIO = -1 where EMP_NO=7782;

select * from EMP;

alter table EMP
drop constraint CH_EMP_SALARIO;



------------------------ ENFERMO

select * from ENFERMO;


alter table ENFERMO
add constraint PK_ENFERMO
primary key (INSCRIPCION);

-- UNIQUE PARA EL DATO DE NSS, SEGURIDAD SOCIAL.

alter table ENFERMO
add constraint U_ENFERMO_NSS
unique (NSS);

-- NO PODEMOS REPETIR PK

insert into ENFERMO values (10995, 'Nuevo', 'Calle nueva', '01/01/2000', 'F', '123')

-- NO PODEMOS REPETIR UNIQUE

insert into ENFERMO values (10995, 'Nuevo', 'Calle nueva', '01/01/2000', 'F', '280862482')
;
select * from ENFERMO;

-- NULOS EN PK?? NO

insert into ENFERMO values (null, 'Nuevo', 'Calle nueva', '01/01/2000', 'F', '123')

-- NULOS EN UNIQUE?? POR SUPUESTO SI LA COLUMNA LO ADMITE

insert into ENFERMO values (12346, 'Nuevo', 'Calle nueva', '01/01/2000', 'F', null)
;
select * from ENFERMO;

-- ELIMINARMOS LAS DOS RESTRICCIONES ANTERIORES
-- QUTAMOS LOS NULL PARA REALIZAR LA INSCRIPCION
;
delete from ENFERMO where NSS is null;

commit;

alter table ENFERMO
drop constraint PK_ENFERMO;

alter table ENFERMO
drop constraint U_ENFERMO_NSS;

-- CREAMOS UNA PRIMARY KEY DE DOS COLUMNAS

alter table ENFERMO
add constraint PK_ENFERMO
primary key (INSCRIPCION, NSS);

-- INTENTAMOS CREAR UN REGISTRO CON DOS DATOS IGUALES EN LA INSCRIPCION Y NSS
;
insert into ENFERMO values (10995,'Languia M.', 'Goya 20', '16/05/1956', 'M', '280862482');

insert into ENFERMO values (88999, 'Languia M.', 'Goya 20', '16/05/1956', 'M', '280862482');

select * from ENFERMO;


--------------------- FOREIGN KEY------------------

-- CREAMOS UNA RELACION ENTRE EMPLEADOS Y DEPARTAMENTOS.

-- EL CAMPO DE RELACION ES DEPT_NO
;
alter table EMP
add constraint FK_EMP_DEPT
foreign key (DEPT_NO)
references DEPT (DEPT_NO);

select * from EMP;

insert into DEPT values (10, 'CONTABILIDAD', 'ELCHE');

-- INSERTAR UN EMPLEADO EN UN DEPT QUE NO EXISTE

insert into EMP values (1111, 'PRUEBA', 'EMPLEADO', 7902, '02/04/2025', 1, 1, 50);

-- DA ERROR POR EL FOREIGN KEY EJECUTADO ANTES: NO PUEDE HABER EMPLEADOS SIN UN 
--DEPTO EXISTENTE.

insert into EMP values (1111, 'nulo', 'EMPLEADO', 7902, '02/04/2025', 1, 1, null);

-- SI VA A DEJAR AGREGAR NULOS PORQUE NO ES UN VALOR NULL, ES UN 'TIPADO'

rollback;

-- VAMOS A PROBAR LA ELIMINACION EN CASCADA Y SET NULL EN CASCADA.

delete from DEPT where DEPT_NO=10;

-- DA ERROR POR TU FOREIGN KEY FK_EMP_DEPT
-- ELIMINALA

alter table EMP
drop constraint FK_EMP_DEPT;

select * from EMP;

alter table EMP
add constraint FK_EMP_DEPT
foreign key (DEPT_NO)
references DEPT (DEPT_NO)
on delete CASCADE;

delete from DEPT where DEPT_NO=10;

-- CON ESTO (CASCADE) SIGNIFICA QUE NO SOLO ELIMINARÁ EL REGISTRO EN LA TABLA QUE 
--ELIGES SINO TAMBIEN LOS QUE ESTÁN RELACIONADOS CON ESE REGISTRO BORRADO EN OTRAS
--TABLAS (O SEA LOS EMPLEADOS DEL DEPT_NO 10 TAMBIEN)

rollback;

alter table EMP
add constraint FK_EMP_DEPT
foreign key (DEPT_NO)
references DEPT (DEPT_NO)
on delete SET NULL;

-- CON ESTO (SET NULL) ELIMINARÁ LOS VALORES REFERENCIADOS COMO NULL. NO TODA LA 
--FILA, SINO LOS DATOS REFERENCIADOS.



-------- CAMPOS DE AUTOINCREMENTO ORACLE 


-- es poner la funcionalidad en la PK directamente.

--Sintaxis SEQUENCE: 

create sequence NOMBRE_SECUENCIA 
minvalue valor ((((OPCIONAL))))
maxvalue valor  ((((OPCIONAL))))
increment by valor_incremento 
start with valor_comienzo; 



-- VAMOS A CREAR SECUENCIAS EN DEPT:


create sequence SEQ_DEPT
increment by 10
start with 40;

drop sequence SEQ_DEPT;




-- UNA SECUENCIA NO SE PUEDE MODIFICAR, SOLO ELIMINAR Y CREAR DE NUEVO.

-- NO PODEMOS ACCEDER A CURRVAL HASTA QUE NO HEMOS EJECUTADO NEXTVAL

select SEQ_DEPT.currval as ACTUAL from DUAL;

select SEQ_DEPT.nextval as ACTUAL from DUAL;

-- SI LO QUEREMOS INSERTAR DEBEMOS LLAMARLO DE FORMA EXPLICITA.

insert into DEPT values (SEQ_DEPT.nextval, 'NUEVO', 'NUEVO');


---

create sequence SEQ_TEST
increment by 1
start with 1;

select SEQ_TEST.currval from DUAL;

-- LO DE ARRIBA DA ERROR PORQUE NO HAY VALOR ACTUAL

select SEQ_TEST.nextval from DUAL;

-- LO DE ARRIBA VA A DAR 1 PORQUE EMPIEZA CON LO DE QUE HAY EN start with EN LA
--CREACION DE LA SECUENCIA.



-- UNA SECUNCIA NO ESTÁ ASOCIADA A NINGUNA TABLA. SE PUEDE USAR PARA OTRAS TABLAS
--PERO TRAERA EL NRO DONDE ACTUALMENTE ESTE (SI ESTÁ EN 90 EN OTRA TABLA, EN OTRA
--TABLA (O LA MISMA) TRAERA EL 91 (SI EL INCREMENTAL ES 1)).

select * from HOSPITAL;

insert into HOSPITAL values (SEQ_DEPT.NEXTVAL, 'El Carmen', 'Calle Pex', '12345',
125);



------------------- PRACTICA --------------------


-- NECESITAMOS LAS SIGUIENTES CARACTERISTICAS DE NUESTRA BASE DE DATOS HOSPITAL

-- 1) PK EN HOSPITAL

-- 2) PK EN DOCTOR

-- 3) NECESITO RELACIONAR DOCTORES CON HOSPITALES

-- 4) LAS PERSONAS DE LA PLANTILLA SOLAMENTE PUEDEN TRABAJAR EN TURNOS M, T, N.


1) 

select * from HOSPITAL;

delete from HOSPITAL where TELEFONO = '12345';

insert into HOSPITAL values (14, 'nuevo', 'nuevo', '12345', 125);

alter table HOSPITAL
add constraint PK_HOSPITAL
primary key (HOSPITAL_COD);

2)

select * from DOCTOR;

insert into DOCTOR values (250, 4385, 'nuevo', 'Enfermeria', 10125);

alter table DOCTOR
add constraint PK_DOCTOR
primary key (DOCTOR_NO);

3)

alter table DOCTOR
add constraint FK_DOCTOR_HOSPITAL
foreign key (HOSPITAL_COD)
references HOSPITAL (HOSPITAL_COD);

4)

alter table PLANTILLA
add constraint CH_PLANTILLA_TURNO_M
check (TURNO in ('M', 'T', 'N'));

insert into PLANTILLA values (19, 6, 11111, 'plantilla', 'Enfermeria', 'P', 45600);



-----------------



















