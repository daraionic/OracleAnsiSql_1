-- CONSULTAS VALIDAS SOLO PARA ORACLE

-- CONSULTAS INSERT ALL: SIRVE PARA HACER UN SOLO INSERT CON VARIOS REGISTROS
--EN VEZ DE UNO POR CADA RGISTRO NUEVO.

SINTAXIS: 

INSERT ALL 
INTO TABLA VALUES (VALOR1, VALOR2) 
INTO TABLA VALUES (VALOR1, VALOR2) 
INTO TABLA (CAMPO1, CAMPO2) VALUES (VALOR1, VALOR2) 
SELECT * FROM DUAL; 

-- se pone DUAL en el ultimo ya que en ORACLE siempre es necesario poner un 
--FROM TABLA y si ponemos DUAL solo inserta las lineas que le dices.

-- Si pones la tabla correspondiente va a ingresar la cantidad registros que
--tenga la tabla (si tiene 4 registros y quiero ingresar 2 nuevos, ingresará 8 
--(4*2) nuevos registros repetidos)


-- Vamos a insertar dos departamentos en dept 

insert all
    into DEPT values ((select max(DEPT_NO)+1 from DEPT), 'ALL', 'ALL')
    into DEPT values ((select max(DEPT_NO)+1 from DEPT), 'ALL2', 'ALL2')
    into DEPT values ((select max(DEPT_NO)+1 from DEPT), 'ALL3', 'ALL3')
select * from DUAL;

select * from DEPT;

rollback;


-- INSERT ANSI SQL (MENOS RÁPIDO)

insert into DEPT values ((select max(DEPT_NO)+1 from DEPT), 'INTO', 'INTO');
insert into DEPT values ((select max(DEPT_NO)+1 from DEPT), 'INTO2', 'INTO2');
insert into DEPT values ((select max(DEPT_NO)+1 from DEPT), 'INTO3', 'INTO3');


-- CREATE TABLE: sirve para crear nuevas tablas

-- no solo crea, sino que además incluye los mismos tipos de dato que el origen.

describe dept;
describe DEPARTAMENTOS;
select * from DEPARTAMENTOS;

create table DEPARTAMENTOS
as
select * from DEPT;

create table DOCTORESHOSPITAL
as
select DOCTOR.DOCTOR_NO as IDDOCTOR, DOCTOR.APELLIDO, HOSPITAL.NOMBRE, 
HOSPITAL.TELEFONO
from DOCTOR
inner join HOSPITAL
on DOCTOR.HOSPITAL_COD = HOSPITAL.HOSPITAL_COD;

select * from DOCTORESHOSPITAL;


-- INSTRUCCION INSERT INTO SELECT

-- Esta instruccion nos permite copiar datos de una tabla Origen a una tabla 
--Destino

-- La diferencia con Create...Select está en que la tabla debe EXISTIR

-- Sin tabla de Destino no podemos ejecutar esta instrucción.

-- La tabla de destino tiene que tener la misma estructura que los datos del 
--Select de Origen.

-- SINTAXIS:

        INSERT INTO DESTINO
        SELECT * FROM ORIGEN;

-- Por ejemplo, vamos a copiar los datos de la tabla DEPT dentro de la 
--tabla DEPARTAMENTOS

insert into DEPARTAMENTOS
select * from DEPT;

select * from DEPARTAMENTOS;

rollback;





-- VARIANTES DE SUSTITUCION

select apellido, oficio, salario, comision from EMP
where emp_no=&numero;

select apellido, oficio, salario, comision from EMP
where apellido='&ape';

select apellido, oficio, salario, comision from EMP
where &condicion;

select APELLIDO, &&CAMPO1, SALARIO, COMISION, DEPT_NO
from EMP
where &CAMPO1='&DATO';

select APELLIDO, &&CAMPO1
from EMP
where &CAMPO1='&DATO';



-- NATURAL JOIN

select apellido, oficio, dnombre, loc
from EMP
natural join DEPT;

select * from EMP
natural join DEPT;

select * from DOCTOR
natural join HOSPITAL
natural join DEPT;



-- USING:

select APELLIDO, LOC, DNOMBRE
from EMP
inner join DEPT
using (dept_no)



----- RECUPERACIÓN JERARQUICA:



-- NECESITAMOS SABER LOS EMPLEADOS QUE TRABAJAN PARA negro (7698)
;
select * from EMP where DIR=7698;



-- MOSTRAMOS LOS EMPLEADOS SUBORDINADOS A PARTIR DEL DIRECTOR jimenez

select LEVEL as NIVEL, APELLIDO, DIR, OFICIO from EMP
connect by prior EMP_NO = DIR
start with APELLIDO = 'jimenez' order by 1;

select LEVEL as NIVEL, APELLIDO, DIR, OFICIO from EMP
connect by EMP_NO = prior DIR
start with APELLIDO = 'jimenez' order by 1;



-- ARROYO A METIDO LA PATA, QUIERO VER TODOS SUS JEFES EN MI DESPACHO.
--MANDA LISTADO, SOY REY.

select LEVEL as NIVEL, APELLIDO, DIR, OFICIO from EMP
connect by EMP_NO = prior DIR
start with APELLIDO = 'arroyo' order by 1;



--- SYS_CONNECT_BY_PATH 

-- La función SYS_CONNECT_BY_PATH() concatena los valores de las ramas del árbol 
--en el recorrido. 

select LEVEL as NIVEL, EMP_NO, APELLIDO, DIR, 
sys_connect_by_path (apellido, '/')as RELACION
from EMP
connect by prior EMP_NO = DIR
start with APELLIDO = 'jimenez' order by 1;


describe PLANTILLA


 