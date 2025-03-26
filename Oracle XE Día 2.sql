select * from EMP;

-- LA MEJOR PRAXIS ES UTILIZAR EL NOMBRE DE LOS CAMPOS
-- CONTROL + ENTER, EJECUTA LA LINEA EN LA QUE ESTAMOS POSICIONADOS

select APELLIDO, OFICIO, SALARIO from EMP;

-- ORDENACION DE DATOS, SIEMPRE AL FINAL Y AFECTA AL SELECT
-- LA ORDENACION SIEMPRE ES ASCENDENTE (asc)
select * from EMP ORDER BY APELLIDO

-- ORDENACION DESCENDIENTE DESC
select * from EMP ORDER BY APELLIDO DESC;

-- ORDENAR POR MAS DE UN CAMPO
select * from EMP order by DEPT_NO, OFICIO;

-- FILTRDO DE REGISTROS
-- OPERADORES DE COMPARACIÓN
/*
= igual
>= mayor o igual
<= menor o igual
> mayor
< menor
<> distinto
*/
-- Oracle, por defecto, dierencia entre mayas y minus en sus textos 
--(string/vachar)

-- TODO LO QUE NO SEA UN NUMERO SE ESCRIBE ENTRE COMILLAS SIMPLES 

-- PARA FILTRAR SE UTILIZA LA PALABRA where Y SE ESCRIBE SOLAMENTE UNA VEZ EN 
-- TODA LA CONSULTA DESPUES DEL FROM QUE ESCRIBAMOS

-- MOSTRAR TODOS LOS EMPLEADOS DEL DEPARTAMENTO 10
select * from EMP where DEPT_NO=10;

-- MOSTRAR TODOS LOS EMPLADOS CUYO OFICIO SEA DIRECTOR
select * from EMP where OFICIO='DIRECTOR';

-- MOSTRAR TODOS LOS EMPLEADOS CUYO OFICIO SEA DIFERENE A DIRECTOR
select * from EMP where OFICIO<>'DIRECTOR'

select * from EMP where OFICIO!='DIRECTOR'

-- OPERADORES RELACIONALES
-- NOS PERMITEN REALIZAR MAS DE UNA PREGUNTA DENTRO DE UNA CONSULTA
/*
OR --> MUESTRA LOS DATOS DE CADA FILTRO
AND --> TODOS LOS FILTROS DEBEN CUMPLIRSE
NOT --> NEGACION DE UNA CONDICION (EVITARLO SIEMPRE)
*/

--MOSTRAR LOS EMPLEADOS DEL DEPARTAMENTO 10 Y QUE TENGAN OFICIO DIRECTOR
select * from EMP where DEPT_NO=10 AND OFICIO='DIRECTOR';
select * from EMP where DEPT_NO=10 OR OFICIO='DIRECTOR' (EMPLEADOS DEL 10 QUE 
NO SEAN DIRECTORES y DIRECTORES QUE NO SEAN DEL 10)

--MOSTRAR LOS EMPLEADOS DEL DEPARTAMENTO 10 Y DEL 20
select * from EMP where DEPT_NO=10 OR DEPT_NO=20

--TENEMOS OTROS OPERADORES ADEMÁS DE LOS STANDARD
--BETWEEN MUESTRA LOS DATOS ENTRE UN RANGO INCLUSIVE
-- MOSTRAR LOS EMPLEADOS CUYO SALARIO ESTE ENTREN 251000 Y 390000
select * from EMP where SALARIO between 251000 and 390000 order by SALARIO

-- PODEMOS HACER LA MISMA CONSULTA CON OPERADORES Y ES EFICIENTE
select * from EMP where SALARIO >= 251000 and SALARIO <= 390000 order by SALARIO

-- LA NEGACION ES ALGO DE LO QUE DEBEMOS HUIR

-- MOSTRAR LOS EMPLEADOS QUE NO SEAN DIRECTOR
select * from EMP where NOT OFICIO='DIRECTOR' (hace dos consultas: una para 
todos los DIRECTOR y otra para todos los otros)

-- PODEMOS REALIZAR LA CONSULTA CON OPERADOR
select * from EMP where OFICIO<>'DIRECTOR' (acá solo se hace una consulta);

-- EXISTE UN OPERADOR PARA BUSCAR COINCIDENCIAS EN TEXTOS
-- NOS PERMITE, MEDIANTE CARACTERES ESPECIALES HACER FILTROS EN TEXTOS
/*
% busca cualquier caracter y longuitud
_ un caracter cualquier
? un caracter numérico
*/

-- MOSTRAR LOS EMPLEADOS CUYO APELLIDO COMIENZA EN s
select * from EMP where APELLIDO like 's%' (% busca cualquier caracter y 
longuitud);

-- MOSTRAR LOS EMPLEADOS CUYO APELLIDO COMIENZA EN s Y FINALIZA CON a
select * from EMP where APELLIDO like 's%a';

-- MOSTRAR TODOS LOS EMPLEADOS CUYO APELLIDO SEA DE 4 LETRAS
select * from EMP where APELLIDO like '____';

-- EXISTE OTRO OPERADOR PARA BUSCAR COINCIDENCIAS DE IGUALDAD EN UN MISMO CAMPO

-- CAMPO: in (valor1, valor2)

-- MOSTRAR LOS EMPLEADOS DEL DEPARTAMENTO 10 Y DEL 20
select * from EMP where DEPT_NO = 10 or DEPT_NO = 20;

-- MOSTRAR LOS EMPLEADOS DEL DEPARTAMENTO 10, 20 Y 30
select * from EMP where DEPT_NO = 10 or DEPT_NO = 20 or DEPT_NO = 30;

-- MOSTRAR LOS EMPLEADOS DEL DEPARTAMENTO 10, 20, 30, 55, 65 Y 77
select * from EMP where DEPT_NO = 10 or DEPT_NO = 20 or DEPT_NO = 30 or 
DEPT_NO = 55 or DEPT_NO = 65 or DEPT_NO = 77
select * from EMP where DEPT_NO in (10, 20, 30, 55, 65, 77)

-- TENEMOS EL OPERADOR not in QUE REALIZA LO MISMO QUE in PERO RECUPERA 
--LOS QUE NO COINCIDEN
-- MOSTRAR TODOS LOS EMPLEADOS QUE NO ESTEN EN EL DEPARTAMENTO 10 Y 20
select * from EMP where not DEPT_NO in (10,20); -- NEGACION
select * from EMP where DEPT_NO not in (10,20); -- OPERADOR


-- CAMPO CALCULADOS
-- UN CAMPO CALCULADO ES UNA HERRAMIENTA EN UNA CONSULTA
-- SIEMPRE TIENE QUE TENER UN ALIAS
-- SIRVE PARA GENERAR CAMPOS QUE NO EXISTAN EN LA TABLA Y LOS PODEMOS CALCULAR
-- MOSTRAR EL APELLIDO, EL SALARIO, COMISION Y EL SALARIO TOTAL 
--(SALARIO + COMISION) DE TODOS LOS EMPLEADOS
-- UN CAMPO CALCULADO SOLO ES PARA EL CURSOR
select APELLIDO, SALARIO, COMISION, (SALARIO + COMISION) from EMP

select APELLIDO, SALARIO, COMISION, (SALARIO + COMISION) as TOTAL from EMP

-- MOSTRAR EL APELLIDO, EL SALARIO, COMISION Y EL SALARIO TOTAL 
--(SALARIO + COMISION) DE TODOS LOS EMPLEADOS
-- DE TODOS LOS EMPLEADOS CUYO SALARIO MAS COMISION ES MAYOR 344500
-- UN CAMPO CALCULADO SOLO ES PARA EL CURSOR (CURSO RESULTADO QUE SE MUESTRA)
select APELLIDO, SALARIO, COMISION, (SALARIO + COMISION) as TOTAL from EMP 
where (SALARIO + COMISION) >= 344500

-- QUEREMOS LA CONSULTA ORIGINAL Y ORDENAR POR ELLA
select APELLIDO, SALARIO, COMISION, (SALARIO + COMISION) as TOTAL from EMP 
order by TOTAL

-- order by ORDENA SOBRE LA TABLA Y EL CURSOR MIENTRAS QUE EL where SOLO SOBRE 
-- LA TABLA

--CLAUSULA DISTINT: SE UTILIZA PARA EL SELECT Y LO QUE REALIZA ES ELIMINAR 
-- REPETIDOS DE LA CONSULTA
--MOSTRAR EL OFICIO DE LOS EMPLEADOS
select OFICIO from EMP (todos);

--MOSTRAR LOS DIFERENTES OFICIOS DE LOS EMPLEADOS
select distinct OFICIO from EMP (sin duplicados);

--MOSTRAR LOS DIFERENTES OFICIOS, APELLIDOS DE LOS EMPLEADOS
select distinct OFICIO, APELLIDO from EMP (si hay dos PRESIDENTE con el mismo 
apellido solo aparecerá uno);

EJERCICIOS:

-- 6) Mostrar todos los enfermos nacidos antes del 11/01/1970
select * from ENFERMO where FECHA_NAC<'11/01/1970'
desc ENFERMO

-- 7) Igual que el anterior, para los nacidos antes del 1/1/1970 ordenados por 
-- número de inscripción
select * from ENFERMO where FECHA_NAC<'01/01/70' order by INSCRIPCION

-- 8) Listar todos los datos de la plantilla del hospital del turno de mañana
select * from PLANTILLA where TURNO='M'

-- 9) Idem del turno de noche.
select * from PLANTILLA where TURNO='N'

-- 10) Listar los doctores que su salario anual supere 3.000.000€
select * from DOCTOR where (SALARIO * 12) > 3000000

-- 11) Visualizar los empleados de la plantilla del turno de mañana que tengan 
-- un salario entre 200.000 y 250.000
select * from PLANTILLA where TURNO = 'M' and SALARIO between 200000 and 
250000
select * from PLANTILLA where TURNO='M' and (SALARIO >=200000 and 
SALARIO <=250000)

-- 12) Visualizar los empleados de la tabla emp que no se dieron de alta entre 
-- el 01/01/1986 y el 12/12/1994.
select * from EMP where FECHA_ALT <='01/01/86' or FECHA_ALT >='12/12/94' 
and OFICIO ='EMPLEADO'
select * from EMP where NOT (FECHA_ALT >='01/01/86' and FECHA_ALT <='12/12/94') 
and OFICIO ='EMPLEADO'

-- 13) Mostrar los nombres de los departamentos situados en Madrid o en 
-- Barcelona
select * from DEPT where LOC = 'MADRID' OR LOC = 'BARCELONA'
select * from DEPT where LOC IN ('MADRID','BARCELONA')


-- CONSULTAS DE AGRUPACIÓN
-- ESTE TIPO DE CONSULTAS NOS PERMITEN MOSTRAR ALGUN RESUMEN SOBRE UN GRUPO
--DETERMINADO DE LOS DATOS.

-- UTILIZAN FUNCIONES DE AGRUPACIÓN PARA CONSEGUIR EL RESUMEN

-- LAS FUNCIONES DEBEN TENER ALTAS

-- COUNT (*): Cuenta el número de registros, incluyendo nulos.

-- COUNT (CAMPO): Cuenta el número de registros sin nulos.

-- SUM (NUMERO): Suma el total de un campo número.

-- AVG (NUMERO): Recupera la media de un campo numérico.

-- MAX (CAMPO): Devuelve el máximo valor de un campo.

-- MIN (CAMPO); Devuelve el mínimo valor de un campo.


-- MOSTRAR EL NUMERO DE REGISTROS DE LA TABLA DOCTOR
select * from DOCTOR

select count(*) as NUMERO_DOCTORES from DOCTOR
select count (APELLIDO) as NUMERO_DOCTORES from DOCTOR

-- PODEMOS COMBINAR SIN PROBLEMA VARIAS FUNCIONES:
-- QUEREMOS EL NUMERO DE DOCTORES Y EL MAXIMO SALARIO
select count (*) as DOCTORES, max(SALARIO) as MAXIMO from DOCTOR

-- LOS DATOS RESULTANTES DE LAS FUNCIONES PODEMOS AGRUPARLOS POR ALGÚN CAMPO/S
--DE LA TABLA
-- CUANDO QUEREMOS AGRUPAR UTILIZARMOS group by DESPUES DEL from
-- TRUCO: DEBEMOS AGRUPAR POR CADA CAMPO QUE NO SEA UNA FUNCION
-- EJEMPLO: CUANTOS DOCTORES EXISTEN POR CADA ESPECIALIDAD
select count (*) as DOCTORES, ESPECIALIDAD 
from DOCTOR 
group by ESPECIALIDAD

-- MOSTRAR NUMERO DE PERSONAS Y MAXIMO SALARIO DE LOS EMPLEADOS POR CADA
--DEPARTAMENTO Y OFICIO
select count (*) as PERSONAS, max(SALARIO) as MAXIMO_SALARIO, DEPT_NO, OFICIO
from EMP
group by DEPT_NO, OFICIO
order by DEPT_NO

-- MOSTRAR EL NUMERO DE PERSONAS DE LA PLANTILLA
select count (*) as PERSONAS from PLANTILLA

-- CUANTAS PERSONAS POR CADA TURNO DE LA PLANTILLA
select count (*) as PERSONAS, TURNO
from PLANTILLA
group by TURNO

-- FILTRANDO EN CONSULTAS DE AGRUPACION
-- TENEMOS DOS POSIBILIDADES:

-- WHERE: ANTES DEL GROUP BY Y PARA FILTRAR SOBRE LA TABLA

-- HAVING: DESPUES DEL GRUOP BY Y PARA FILTRAR SOBRE EL CONJUNTO / SELECT

-- MOSTRAR CUANTOS EMPLEADOS TENEMOS POR CADA OFICIO QUE COBREN MAS DE 200000
-- WHERE: ANTES DEL GROUP BY Y PARA FILTRAR SOBRE LA TABLA
select count (*) as EMPLEADOS, OFICIO
from EMP
where SALARIO > 200000
group by OFICIO;

-- MOSTRAR CUANTOS EMPLEADOS TENEMOS POR CADA OFICIO QUE COBREN MAS DE 200000 Y
--QUE SEAN ANALISTA O VENDEDOR
-- HAVING: DESPUES DEL GRUOP BY Y PARA FILTRAR SOBRE EL CONJUNTO
select count (*) as EMPLEADOS, OFICIO
from EMP
group by OFICIO
having OFICIO in ('ANALISTA', 'VENDEDOR');


-- CUANDO NO PODEMOS DECIDIR Y ESTAMOS OBLIGADOS A UTILIZAR HAVING:
-- SI QUEREMOS FILTRAR POR UNA FUNCION DE AGRUPACION
-- MOSTRAR CUANTOS EMPLEADOS TENEMOS POR CADA OFICIO
-- SOLAMENTE DOND TENGAMOS 2 O MAS EMPLEADOS DEL MISMO OFICIO
select count (*) as EMPLEADOS, OFICIO
from EMP
group by OFICIO
having count (*) > 2


--PRACTICA
1) Encontrar el salario medio de los analistas, mostrando el número de los 
--empleados con oficio analista. 

select count(*) as NUMEROEMPLEADOS, oficio,
avg(salario) as SALARIOMEDIO from  emp group by oficio having oficio ='ANALISTA'	

2) Encontrar el salario más alto, mas bajo y la diferencia entre ambos de todos
--los empleados con oficio EMPLEADO. 

select max(salario) as SALARIOMAX, 
min(salario) as SALARIOMIN, 
max(salario) - min(salario) as DIFERENCIA from  emp 

select oficio,
max(salario) as SALARIOMAX, 
min(salario) as SALARIOMIN, 
max(salario) - min(salario) as DIFERENCIA from  emp 
group by oficio having oficio ='EMPLEADO'


select count(*) as NUMEROEMPLEADOS, oficio,
max(salario) as SALARIOMAX, 
min(salario) as SALARIOMIN, 
max(salario) - min(salario) as DIFERENCIA from  emp 
group by oficio having oficio ='EMPLEADO'


3) Visualizar los salarios mayores para cada oficio. 

select oficio, 
max(salario) as SALARIOMAXIMO 
from emp 
group by oficio 

4) Visualizar el número de personas que realizan cada oficio en cada 
--departamento ordenado por departamento. 

select count (*) as PERSONAS, OFICIO, DEPT_NO
from EMP
group by OFICIO, DEPT_NO
order by DEPT_NO

select count (*) as PERSONAS, OFICIO, DEPT_NO
from EMP
group by OFICIO, DEPT_NO
order by 3

5) Buscar aquellos departamentos con cuatro o más personas trabajando. 

select count (*) as PERSONAS, DEPT_NO
from EMP
group by DEPT_NO
having count (*) >= 4

6) Mostrar el número de directores que existen por departamento. 

select count(*) as NUMEROEMPLEADOS, dept_no  
from emp 
where oficio = 'DIRECTOR' 
group by dept_no 

7) Visualizar el número de enfermeros, enfermeras e interinos que hay en 
--la plantilla, ordenados por la función. 

select * from PLANTILLA

select count (*) as NRO_EMPLEADO, FUNCION
from PLANTILLA
group by FUNCION
having FUNCION in ('ENFERMERO', 'ENFERMERA', 'INTERINO')
order by FUNCION

8) Visualizar departamentos, oficios y número de personas, para aquellos 
-- departamentos que tengan dos o más personas trabajando en el mismo oficio.

select DEPT_NO, OFICIO, count (*) as PERSONAS
from EMP
group by DEPT_NO, OFICIO
having count (DEPT_NO) >= 2

9) Calcular el salario medio, Diferencia, Máximo y Mínimo de cada oficio. 
--Indicando el oficio y el número de empleados de cada oficio. 

select oficio, count(*) as EMPLEADOS 
, min(salario) as SALARIOMAXIMO
, max(salario) as SALARIOMINIMO 
, max(salario) - min(salario) as DIFERENCIA 
, avg(salario) as MEDIA 
 from emp group by  oficio 
 
10) Calcular el valor medio de las camas que existen para cada nombre de sala. 
--Indicar el nombre de cada sala y el número de cada una de ellas.

select * from sala

select NOMBRE, count (*) as SALAS, 
avg (NUM_CAMA) as MEDIA
from SALA
group by NOMBRE

11) Calcular el salario medio de la plantilla de la sala 6, según la función que 
--realizan. Indicar la función y el número de empleados. 

select * from PLANTILLA

select FUNCION, count(*) as NUMERO_EMPLEADOS,
avg (SALARIO) as MEDIA
from PLANTILLA
where SALA_COD=6
group by FUNCION

12)Averiguar los últimos empleados que se dieron de alta en la empresa en cada
--uno de los oficios, ordenados por la fecha. 

select max(fecha_alt) AS FECHAMAXIMA, Oficio 
from emp 
group by oficio 
order by 1

13) Mostrar el número de hombres y el número de mujeres que hay entre 
--los enfermos;

select * from ENFERMO;

select SEXO, count (*) as NUMERO_ENFERMOS
from ENFERMO
group by SEXO

14) Mostrar la suma total del salario que cobran los empleados de la plantilla 
--para cada función y turno. 

select funcion, Turno, sum(salario) as SUMA_SALARIAL  
from plantilla 
group by funcion, Turno 

15) Calcular el número de salas que existen en cada hospital. 

select * from SALA

select HOSPITAL_COD, count (SALA_COD) as NUMERO_SALAS
from SALA
group by HOSPITAL_COD

16) Mostrar el número de enfermeras que existan por cada sala.

select * from PLANTILLA

select SALA_COD, count (*)
from PLANTILLA
where FUNCION = 'ENFERMERA'
group by SALA_COD
 



