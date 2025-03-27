-- CONSULTAS DE COMBINACION

-- SON IMPORTANTES PORQUE NOS PERMITEN MOSTRAR DATOS DE VARIAS TABLAS QUE DEBEN
--ESTAR RELACIONADAS ENTRE SI MEDIANTE ALGUNA CLAVE

-- 1) NECESITAMOS COLUMNAS/CAMPOS DE RELACIÓN ENTRE LAS TABLAS

-- 2) DEBEMOS PONER EL NOMBRE DE CADA TABLA Y CADA CAMPO EN LA CONSULTA

-- SINTAXIS:
select TABLA1.CAMPO1, TABLA1.CAMPO2,
TABLA2.CAMPO1, TABLA 2.CAMPO2,
from TABLA1
inner join TABLA2
on TABLA1.CAMPO_RELACION = TABLA2.CAMPO_RELACION;

-- MOSTRAR EL APELLIDO, EL OFICIO DE EMPLEADOS JUNTO A SU NOMBRE DE DEPARTAMENTO
--Y LOCALIDAD.

select EMP.APELLIDO, EMP.OFICIO, DEPT.DNOMBRE, DEPT.LOC
from EMP
inner join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO


-- TENEMOS OTRA SINTAXIS PARA REALIZAR LOS JOIN

select EMP.APELLIDO, EMP.OFICIO, DEPT.DNOMBRE, DEPT.LOC
from EMP, DEPT
where EMP.DEPT_NO = DEPT.DEPT_NO;

-- MEJOR LA PRIMERA QUE EMPEZÓ A USARSE DESDE 1999. LA OTRA ERA DEL 92 Y
--TARDABA MUCHO EN HACER CONSULTAS.


-- PODEMOS REALIZAR, POR SUPUESTO NUESTROS WHERE
-- QUEREMOS MOSTRAR SOLO LOS DATOS DE 'MADRID'

select EMP.APELLIDO, EMP.OFICIO, DEPT.DNOMBRE, DEPT.LOC
from EMP
inner join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO
where DEPT.LOC = 'MADRID';


-- NO ES OBLIGATORIO INCLUIR EL NOMBRE DE LA TABLA ANTES DEL CAMPO A MOSTRAR EN
--EN EL SELECT PERO SI RECOMENDABLE PARA QUE SEPAMOS DE QUE TABLA ES CADA COLUM;

select EMP.APELLIDO, OFICIO, DEPT.DNOMBRE, LOC
from EMP
inner join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO;


-- PODEMOS INCLUIR ALIAS A LOS NOMBRES DE LAS TABLAS PARA LLAMARLAS ASÍ A LO 
--LARGO DE LAS CONSULTAS.
-- ES UTIL CUANDO TENEMOS TABLAS CON NOMBRES MUY LARGOS.
-- CUANDO PONEMOS ALIAS, LA TABLA SE LLAMARÁ ASÍ PARA TODA LA CONSULTA.

select e.APELLIDO, e.OFICIO, d.DNOMBRE, d.LOC
from EMP e
inner join DEPT d
on e.DEPT_NO = d.DEPT_NO order by d.LOC;



-- TENEMOS MULTIPLES TIPOS DE JOIN EN LAS BASES DE DATOS

-- inner: COMBINA LOS RESULTADOS DE LAS DOS TABLAS.

-- left: COMBINA LAS DOS TABLAS Y TAMBIÉN LA TABLA IZQUIERDA.

-- right: COMBINA LAS DOS TABLAS Y FUERZA LA TABLA DERECHA.

-- full: COMBINA LAS DOS TABLAS Y FUERZA LAS DOS TABLAS.

-- cross: PRODUCTO CARTESIANO, COMBINAR CADA DATO DE UNA TABLA CON LOS OTROS 
--DATOS DE LA TABLA.

select DISTINCT DEPT_NO from EMP;
select * from DEPT;


-- TENEMOS UN DEPTO: 40, PRODUCCION, GRANADA SIN EMPLEADOS
-- VAMOS A CREAR UN NUEVO EMPLEADO QUE NO TENGA DEPARTAMENTO
-- TENEMOS UN EMPLEADO SIN DEPARTAMENTO EN EL 50
-- left: COMBINA LAS DOS TABLAS Y TAMBIÉN LA TABLA IZQUIERDA.
-- LA TABLA DE LA IZQUIERDA ES ANTES DEL JOIN

select EMP.APELLIDO, DEPT.DNOMBRE, DEPT.LOC
from EMP
left join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO;


-- right: COMBINA LAS DOS TABLAS Y FUERZA LA TABLA DERECHA.
-- LA TABLA DE LA DERECHA ES DESPUES DEL JOIN

select EMP.APELLIDO, DEPT.DNOMBRE, DEPT.LOC
from EMP
right join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO;


-- full: COMBINA LAS DOS TABLAS Y TAMBIEN LOS DATOS QUE NO COMBINE

select EMP.APELLIDO, DEPT.DNOMBRE, DEPT.LOC
from EMP
full join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO;


-- cross: PRODUCTO CARTESIANO. NO LLEVA ON.

select EMP.APELLIDO, DEPT.DNOMBRE, DEPT.LOC
from EMP
cross join DEPT
order by EMP.APELLIDO


-- 





















-- MOSTRAR LA MEDIA SALARIAL DE LOS DOCTORES POR HOSPITAL

select * from DOCTOR;

select avg (SALARIO) as MEDIA, HOSPITAL_COD
from DOCTOR
group by HOSPITAL_COD;

select * from HOSPITAL;


-- MOSTRAR LA MEDIA SALARIAL DE LOS DOCTORES POR HOSPITAL MOSTRANDO EL NOMBRE
--DEL HCO.

select avg (DOCTOR.SALARIO) as MEDIA, HOSPITAL.NOMBRE
from DOCTOR
inner join HOSPITAL
on DOCTOR.HOSPITAL_COD = HOSPITAL.HOSPITAL_COD
group by HOSPITAL.NOMBRE;



-- MOSTRAR EL NUMERO DE EMPLEADOS QUE EXISTEN POR CADA LOCALIDAD.

select * from EMP

select count (EMP.EMP_NO) as EMPLEADOS, DEPT.LOC
from EMP
right join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO
group by DEPT.LOC;



03 - CONSULTAS DE COMBINACION_JOIN

--1) Seleccionar el apellido, oficio, salario, numero de departamento y su 
--nombre de todos los empleados cuyo salario sea mayor de 300000 

select * from EMP

select * from DEPT

select EMP.APELLIDO, EMP.OFICIO, EMP.SALARIO, EMP.DEPT_NO, DEPT.DNOMBRE
from EMP
inner join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO
where EMP.SALARIO > 300000


-- 2) Mostrar todos los nombres de Hospital con sus nombres de salas 
--correspondientes. 

select * from HOSPITAL;

select * from SALA

select HOSPITAL.NOMBRE as NOMBRE_HOSPITAL, SALA.NOMBRE as NOMBRE_SALA
from HOSPITAL
inner join SALA
on HOSPITAL.HOSPITAL_COD = SALA.HOSPITAL_COD
order by HOSPITAL.NOMBRE

- tienen el mismo nombre la columnas y por eso le ponemos alias.

-- 3) Calcular cuántos trabajadores de la empresa hay en cada ciudad. 

select * from EMP;

select * from DEPT;

select DEPT.LOC, count (EMP_NO) as NUMERO_TRABAJADORES
from EMP
right join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO
group by DEPT.LOC


-- 4) Visualizar cuantas personas realizan cada oficio en cada departamento 
--mostrando el nombre del departamento. 

select DEPT.DNOMBRE, count (EMP.EMP_NO) as NUMERO_EMPLEADOS, EMP.OFICIO
from EMP
right join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO
group by DEPT.DNOMBRE, EMP.OFICIO


--5) Contar cuantas salas hay en cada hospital, mostrando el nombre de las 
--salas y el nombre del hospital. 

select * from HOSPITAL;

select * from SALA;

select HOSPITAL.NOMBRE as NOMBRE_HOSPITAL, SALA.NOMBRE as NOMBRE_SALA, 
count (SALA.SALA_COD)as NUMERO_SALAS
from HOSPITAL
inner join SALA
on HOSPITAL.HOSPITAL_COD = SALA.HOSPITAL_COD
group by HOSPITAL.NOMBRE, SALA.NOMBRE;


-- 6) Queremos saber cuántos trabajadores se dieron de alta entre el año 1997 
--y 1998 y en qué departamento. 

select * from EMP;

select * from DEPT;

select DEPT.DNOMBRE, count (EMP.EMP_NO) as ALTAS
from EMP
inner join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO
where EMP.FECHA_ALT >='01.01.1997' and EMP.FECHA_ALT <= '01.01.1998'
group by DEPT.DNOMBRE


--7) Buscar aquellas ciudades con cuatro o más personas trabajando. 

select * from EMP order by DEPT_NO;

select * from DEPT;

select DEPT.LOC, count (EMP.EMP_NO) as NUM_EMPLEADOS
from DEPT
inner join EMP
on EMP.DEPT_NO = DEPT.DEPT_NO
group by DEPT.LOC
having count (DEPT.DEPT_NO) >= 4


--8) Calcular la media salarial por ciudad.  Mostrar solamente la media para 
--Madrid y Sevilla. 

select * from EMP order by DEPT_NO;

select * from DEPT;

select DEPT.LOC,
avg (EMP.SALARIO) as MEDIA_SALARIO
from DEPT
inner join EMP
on EMP.DEPT_NO = DEPT.DEPT_NO
where DEPT.LOC = 'MADRID' or DEPT.LOC = 'SEVILLA'
group by DEPT.LOC


select DEPT.LOC,
avg (EMP.SALARIO) as MEDIA_SALARIO
from DEPT
inner join EMP
on EMP.DEPT_NO = DEPT.DEPT_NO
group by DEPT.LOC
having DEPT.LOC in ('MADRID', 'SEVILLA')


-- 9) Mostrar los doctores junto con el nombre de hospital en el que ejercen, 
--la dirección y el teléfono del mismo.

select * from EMP order by DEPT_NO;

select * from DOCTOR

select * from HOSPITAL;

select DOCTOR.APELLIDO, HOSPITAL.NOMBRE, HOSPITAL.DIRECCION, HOSPITAL.TELEFONO
from DOCTOR
inner join HOSPITAL
on DOCTOR.HOSPITAL_COD = HOSPITAL.HOSPITAL_COD;


--10)Mostrar los nombres de los hospitales junto con el mejor salario de los 
--empleados de la plantilla de cada hospital. 

select HOSPITAL.NOMBRE,
max (PLANTILLA.SALARIO) as MAX_SALARIO
from HOSPITAL
inner join PLANTILLA
on HOSPITAL.HOSPITAL_COD = PLANTILLA.HOSPITAL_COD
group by HOSPITAL.NOMBRE;

--11) Visualizar el Apellido, función y turno de los empleados de la plantilla 
--junto con el nombre de la sala y el nombre del hospital con el teléfono.

-- POR CADA TABLA UN JOIN Y UN ON
/*
select TABLA1.CAMPO1, TABLA1.CAMPO2, 
TABLA2.CAMPO1, TABLA2.CAMPO2, 
TABLA3.CAMPO1, TABLA3.CAMPO2,
TABLA4.CAMPO1, TABLA4.CAMPO2,
from TABLA1
inner join TABLA2
on TABLA1.RELACION=TABLA2.RELACION
inner join TABLA3
on TABLA1.RELACION=TABLA3.RELACION
inner join TABLA4
on TABLA1.RELACION=TABLA4.RELACION
*/

select * from PLANTILLA;
select * from SALA;
select * from HOSPITAL;

select PLANTILLA.APELLIDO, PLANTILLA.FUNCION, PLANTILLA.TURNO, 
SALA.NOMBRE as NOMBRE_SALA, 
HOSPITAL.NOMBRE as NOMBRE_HOSPITAL, HOSPITAL.TELEFONO
from PLANTILLA
inner join HOSPITAL
on PLANTILLA.HOSPITAL_COD=HOSPITAL.HOSPITAL_COD
inner join SALA
on HOSPITAL.HOSPITAL_COD=SALA.HOSPITAL_COD
and PLANTILLA.SALA_COD = SALA.SALA_COD;



-- 12) Visualizar el máximo salario, mínimo salario de los Directores 
--dependiendo de la ciudad en la que trabajen. 
--Indicar el número total de directores por ciudad. 

select * from EMP order by DEPT_NO;

select * from DEPT

select count (EMP.OFICIO) as NUMERO_DIRECTORES, 
max (EMP.SALARIO) as SALARIO_MAX, 
min (EMP.SALARIO)as SALARIO_MIN, 
DEPT.LOC
from EMP
inner join DEPT
on EMP.DEPT_NO = DEPT.DEPT_NO
where EMP.OFICIO = 'DIRECTOR'
group by DEPT.LOC


--13)Averiguar la combinación de que salas podría haber 
--por cada uno de los hospitales. 

select * from HOSPITAL;

select * from SALA;

select SALA.NOMBRE, HOSPITAL.NOMBRE
from HOSPITAL
cross join SALA













