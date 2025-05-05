-- SUBCONSULTAS

-- Son consultas que necesitan del resultao de otra consulta para poder ser 
--ejecutadas. No son autonomas, necesian de algo.

-- No importa el nivel de subconsulta, aunque pueden relantizar la respuesta

-- Generan bloqueos en consultas select, lo qe también relantiza las respuestas.

-- Debemos intentar evitarlas en la medida de lo posible con select

-- Ejemplos:

-- QUIERO VISUALIZAR LOS DATOS DEL EMPLEADO QUE MAS COBRA DE LA EMPRESA (EMP)

select max (SALARIO) from EMP;
- 650000

select * from EMP where SALARIO = 650000;

-- ENTONCES PODEMOS EJECUTAR AMBAS CONSULTAS A LA VEZ Y SE ANIDA EL RESULTADO DE
--DE UNA CONSULTA CON LA IGUALDAD DE LA RESPUESTA DE OTRA CONSULTA.
-- LAS SUBCONSULTAS VAN ENTRE PARENTESIS

select * from EMP where SALARIO =(select max (SALARIO) from EMP);


-- MOSTRAR LOS EMPLEADOS QUE TIENEN EL MISMO OFICIO QUE EL EMPLEADO gil Y QUE
--COBREN MENOS QUE jimenez

select * from EMP where OFICIO = 
(select OFICIO from EMP where APELLIDO = 'gil')
and SALARIO < (select SALARIO from EMP where APELLIDO='jimenez');


-- MOSTRAR LOS EMPLEADOS QUE TIENEN EL MISMO OFICIO QUE EL EMPLEADO gil Y EL
-- MISMO OFICIO QUE jimenez

-- SI UNA SUBCONSULA DEVUELVE MAS DE UN VALOR (DIRECTOR, ANALISTA), SE UTILIZA 
--EL OPERADOR IN

select * from EMP where OFICIO in 
(select OFICIO from EMP where APELLIDO = 'gil' or APELLIDO='jimenez')


-- POR SUPUESTO, PODEMOS UTILIZAR SUBCONSULTAS PARA OTRAS TABLAS

-- MOSTRAR EL APELLIDO Y EL OFICIO DE LOS EMPLEADOS DEL DEPARTAMENTO DE MADRID

select APELLIDO, OFICIO from EMP where DEPT_NO =
(select DEPT_NO from DEPT where LOC='MADRID')

-- ESTO DE ARRIBA ESTA MAL HECHO YA QUE LA TABLA EMP Y DEPT ESTAN RELACIONADAS,
--LAS SUBCONSULTAS SOLO ESTAN BIEN CUANDO LAS TABLAS NO SE RELACIONAN.

select EMP.APELLIDO, EMP.OFICIO
from EMP
inner join DEPT
on EMP.DEPT_NO=DEPT.DEPT_NO
where DEPT.LOC='MADRID'




-- CONSULTAS DE UNION

-- MUESTRAN, EN UN MISMO CURSOR, UN MISMO CONJUNTO DE RESULTADOS.

-- ESTAS COSNULTAS SE UTILIZAN COMO CONCEPTO, NO COMO RELACION.

-- DEBEMOS SERGUIR 3 NORMAS:

--1) LA PRIMERA CONSULTA ES LA JEFA

--2) TODAS LAS CONSULTAS DEBEN TENER EL MISMO NUMERO DE COLUMNAS

--3) TODAS LAS COLUMNAS DEBEN TENER EL MISMO TIPO DE DATO ENTRE SI

-- EN NUESTRA BBDD TENEMOS DATOS DE PERSONAS EN DIFERENTES TABLAS

--EMP, PLANTILLA Y DOCTOR

select APELLIDO, OFICIO, SALARIO from EMP;

select APELLIDO, FUNCION, SALARIO from PLANTILLA;

-- SI EJECUTAMOS LAS DOS AL MISMO TIEMPO HABRA DOS PESTAÑAS: UNA POR CADA CURSOR

select APELLIDO, OFICIO, SALARIO from EMP
union
select APELLIDO, FUNCION, SALARIO from PLANTILLA;

-- SI QUIERO NOMBRAR SALARIO as SUELDO SOLO SERVIRIA EN LA PRIMERA CONSULTA YA 
--QUE ES LA JEFA.

select APELLIDO, OFICIO, SALARIO from EMP
union
select APELLIDO, FUNCION, SALARIO from PLANTILLA
union
select APELLIDO, ESPECIALIDAD, SALARIO from DOCTOR;

-- POR SUPUESTO PODEMOS ORDENAR SIN PROBLEMAS PERO ES RECOMNDABLE POR NUMERO DE
--COLUMNA.
-- SE PUEDE HACER POR NOMBRE DE COLUMNA PERO NOS QUITA LA POSIBILIDAD DE PONER
--ALIAS
-- SI TODAS LAS COLUMNAS SE LLAMAN IGUAL SE PUEDE FILTRAR CON NOMBRE, PERO SI SE 
--LLAMAN DIFERENTE (COLUMNA 2) NO SE PUEDE POR NOMBRE.

select APELLIDO, OFICIO, SALARIO from EMP
union
select APELLIDO, FUNCION, SALARIO from PLANTILLA
union
select APELLIDO, ESPECIALIDAD, SALARIO from DOCTOR
order by 3;









-- PODEMOS PERFECTAMENTE FILRAR LOS DATOS DE LA CONSULTA.
-- POR EJEMPLO, MOSTRAR LOS DATOS DE LAS PERSONAS QUE COBREN MENOS DE 300000

select APELLIDO, OFICIO, SALARIO from EMP
union
select APELLIDO, FUNCION, SALARIO from PLANTILLA
union
select APELLIDO, ESPECIALIDAD, SALARIO from DOCTOR
where SALARIO < 300000
order by 1;

-- CADA FILTRO ES AFECTADO A CADA UNA DE LAS CONSULTAS.
-- EL WHERE DE ARRIBA SOLO VA A FILTRAR LA CONSULTA DE ARRIBA, NO DE TODA LAS
--QUE ESTAN EN UNION. SI QUIERO FILTRAR POR TODOS EL WHERE TIENE QUE IR EN CADA
--CONSULTA INDIVIDUAL:

select APELLIDO, OFICIO, SALARIO from EMP
where SALARIO < 300000
union
select APELLIDO, FUNCION, SALARIO from PLANTILLA
where SALARIO < 300000
union
select APELLIDO, ESPECIALIDAD, SALARIO from DOCTOR
where SALARIO < 300000
order by 1;

-- UNION ELIMINA LOS RESULTADOS REPETIDOS Y POR ESTO AUNQUE LA CONSULTA SEA LA
--MISMA SOLO NOS APARECERÁ UNOS RESULTADOS

select APELLIDO, OFICIO from EMP
union
select APELLIDO, OFICIO from EMP;

-- PERO SI QUEREMOS REPETIR HAY QUE USAR UNION ALL

select APELLIDO, OFICIO from EMP
union all
select APELLIDO, OFICIO from EMP;



-- SELECT TO SELECT

-- ES UNA CONSULTA SOBRE UN CURSOR (SELECT YA REALIZADO)

-- CUANDO HACEMOS UN SELECT, EN REALIDAD ESTAMOS RECUPEANDO DATOS DE UNA TABLA

-- ESTE TIPO DE CONSULTAS NOS PERMITEN RECUPERAR DATOS DE UN SELECT YA.

-- REALIZADO, LOS WHERE Y DEMAS SE HACEN SOBRE EL CURSOR

-- SINTAXIS:

select * from 
(select TABLA1.CAMPO1 as ALIAS, TABLA1.CAMPO2 from TABLA1
union
select TABLA2.CAMPO1, TABLA2.CAMPO2 from TABLA 2) CONSULTA
where CONULTA.ALIAS = 'VALOR';

-- QUEREMOS MOSTRAR LOS DATOS D TODAS LAS PERSONAS DE MI BBDD (EMP, DOCTOR, 
--PLANTILLA)

-- SOLAMENTE QUEREMOS LOS QUE COBREN MENOS SUELDO DE 300.000

select APELLIDO, OFICIO, SALARIO from EMP
union
select APELLIDO, FUNCION, SALARIO from PLANTILLA
union
select APELLIDO, ESPECIALIDAD, SALARIO from DOCTOR;

select * from
(select APELLIDO, OFICIO, SALARIO as SUELDO from EMP
union
select APELLIDO, FUNCION, SALARIO from PLANTILLA
union
select APELLIDO, ESPECIALIDAD, SALARIO from DOCTOR) CONSULTA
where CONSULTA.SUELDO < 300000;


-- CONSULTAS A NIVEL DE FIL

-- SON CONSULTAS PARA DAR FORMATO A LA SALIDA DE DATOS.

-- NO MODIFICAN LOS DATOS DE LA TABLA, LOS MUESTRAN DE OTRA FORMA SEGUN YO LO 
--NECESITE.

-- VAN CON PREGUNTAS EN LA CONSULTA.

-- SINTAXIS EVALUANDO UN CAMPO:

select CAMPO1, CAMPO2,
case CAMPO3
when 'dato1' then 'valor1'
when 'dato2' then 'valor2'
else 'valor3'
end as ALIAS
from TABLA;

select * from PLANTILLA;

-- MOSRAMOS LOS APELLIDOS DE LA PLANTILLA, PERO CON SU TURNO QUE SE VEA BIEN
-- (MAÑANA, TARDE, NOCHE)

select APELLIDO, FUNCION,
case TURNO
when 'T' then 'TARDE'
when 'M' then 'MAÑANA'
else 'NOCHE'
end as TURNO
from PLANTILLA;

-- 2) EVALUAR POR UN OPERADOR (RANGO, MAYOR O MENOR, DISTINTO)

select CAMPO1, CAMPO2,
case 
when CAMPO3 <= 800 then 'RESULTADO1'
when CAMPO3 > 800 then 'RESULTADO2'
end as FORMATO
from TABLA;

-- SALARIOS DE LA PLANILLA

select APELLIDO, FUNCION, SALARIO,
case
when SALARIO >= 250000 then 'SALARIO CORRECTO'
when SALARIO >= 170000 and SALARIO < 250000 then 'MEDIA SALARIAL'
else 'BECARIO'
end as RANGO_SALARIAL
from PLANTILLA;


-- 1) MOSTRAR LA SUMA SALARIAL DE LOS EMPLEADOS POR SU NOMBRE DE DEPARTAMENTO

-- 2) MOSTRAR LA SUMA SALARIAL DE LOS DOCTORES POR SU NOMBRE DE HOSPITAL

-- 3) ME GUSTARIA PODER VER TODO JUNTO EN UNA MISMA CONSULTA

select * from EMP;

select * from DEPT;

select sum (EMP.SALARIO) as SUMA_SALARIO, DEPT.DNOMBRE as DEPARTAMENTO
from EMP
inner join DEPT
on EMP.DEPT_NO=DEPT.DEPT_NO
group by DEPT.DNOMBRE;

select * from DOCTOR;

select * from HOSPITAL;

select sum (DOCTOR.SALARIO) as SUMA_SALARIO, HOSPITAL.NOMBRE as HOSPITAL
from HOSPITAL
inner join DOCTOR
on HOSPITAL.HOSPITAL_COD=DOCTOR.HOSPITAL_COD
group by HOSPITAL.NOMBRE;

select sum (EMP.SALARIO) as SUMA_SALARIO, DEPT.DNOMBRE as DEPARTAMENTO_HOSPITAL
from EMP
inner join DEPT
on EMP.DEPT_NO=DEPT.DEPT_NO
group by DEPT.DNOMBRE
union
select sum (DOCTOR.SALARIO) as SUMA_SALARIO, HOSPITAL.NOMBRE as HOSPITAL
from HOSPITAL
inner join DOCTOR
on HOSPITAL.HOSPITAL_COD=DOCTOR.HOSPITAL_COD
group by HOSPITAL.NOMBRE;





-- CONSULTAS DE ACCION

-- SON CONSULTAS PARA MODIFICAR LOS REGISTROS DE LA BASE DE DATOS

-- EN ORACLE, LAS COSULTAS DE ACCION SON TRANSACCIONALES, ES DECIR, SE ALMACENAN
--DE FORMA TEMPORAL POR SESION.

-- PARA DESHACER LOS CAMBIOS O PARA HACERLOS PERMANENTES TENEMOS DOS PALABRAS:

-- commit: HACE LOS CAMBIOS PERMANENTES.

-- rollback: DESHACE LOS CAMBIOS REALIZADOS.

-- 1) INSERTO 2 REGISTROS NUEVOS
-- 2) COMMIT PERMANENTE
-- 3) INSERTO OTRO REGISTRO NUEVO (3)
-- 4) rollback: SOLAMENTE QUITA EL PUNTO 3.


-- TENEMOS TRES TIPOS DE CONSULTAS DE ACCION

-- INSERT: Inserta un nuevo registro en una tabla

-- UPDATE: Modifica uno o varios registros de una tabla

-- DELETE: Elimina uno o varios registros de una tabla.

----------------------------------------

-- INSERT:

-- CADA REGISTRO A INSERTAR ES UNA INSTRUCCIÓN INSERT.

-- INSERTAR 5 REGISTROS, SON 5 INSERT

-- TENEMOS DOS TIPOS DE SINTAXIS:

-- SINTAXIS: dos tipos

-- 1) INSERTAR TODOS LOS DATOS DE LA TABLA: Debemos indicar toda las 
--columnas/campos de la tabla y en el mismo orden que estén en la propia tabla.

insert into TABLA values (valor1, valor2, valor3, valor4);

insert into DEPT values (50, 'ORACLE', 'BERNABEU');
commit;
insert into DEPT values (51, 'ORACLE', 'BERNABEU');
rollback;

select * from DEPT;


-- 2) INSERTA SOLAMENTE ALGUNOS DATOS DE LA TABLA: Debemos indicar el nombre de 
--las columnas que deseamos insertar y los valores irán en dicho orden, la 
--tabla no tiene nada que ver.

insert into TABLA (campo3, campo7) values (valor3, valor7)

-- INSERTAR UN NUEVO DEPTO EN ALMERIA, NO SE LO QUE VOY HACER TODAVIA...

insert into DEPT (DEPT_NO, LOC) values (55, 'ALMERIA');


-- LAS SUBCONSULTAS SON EVITABLES SI ESTAMOS EN UN SELECT, PERO SUPER UTILES SI 
--ESTAMOS EN UNA CONSULTA DE ACCION.

-- NECESITO UN DEPARTAMENTO DE SIDRA EN GIJON

-- GENERAR EL SIGUIENTE NUMERO DISPONIBLE EN LA CONSULTA DE ACCION

select max (DEPT_NO) + 1 from DEPT;

inser into DEPT values (56, 'SIDRA', 'GIJON')
o
inser into DEPT values ((select max (DEPT_NO) + 1 from DEPT), 'SIDRA', 'GIJON')

rollback

select * from DEPT;

-- DELETE

-- ELIMINA UNA O VARIAS FILAS DE UNA TABLA. SI NO EXISTE NADA PARA ELIMINAR, NO
--HACE NADA.

-- SINTAXIS:
-- delete form TABLA.
-- LA SINTAXIS ANTERIOR ELIMINA TODOS LOS REGISTROS DE LA TABLA.
-- OPCIONAL, INCLUIR WHERE
-- ELIMINAR EL DEPARTAMENTO DE ORACLE Y EL DE ALMERIA

delete from DEPT where DNOMBRE ='ORACLE';

delete from DEPT where LOC ='ALMERIA';

select * from DEPT

-- SI HACEMOS rollback, VUELVEN LOS REGISTROS.

rollback



-- MUY UTIL UTILIZAR SUBCONSULTAS PARA DELETE

-- ELIMINAR TODOS LOS EMPLEADOS DE GRANADA

delete from EMP where DEPT_NO=40

delete from EMP where DEPT_NO=(select DEPT_NO from DEPT where LOC='GRANADA')



-- UPDATE

-- MODIFICA UNA O VARIAS FILAS DE UNA TABLA. PUEDE MODIFICAR VARIAS COLUMNAS A 
--LA VEZ

-- SINTAXIS:
-- update TABLA set CAMPO1=VALOR1, CAMPO2=VALOR2

-- ESTA CONSULTA MODIFICA TODAS LAS FILAS DE LA TABLA.

-- ES CONVENIENTE UTILIZAR WHERE

-- MODIFICAMOS EL SALARIO DE LA PLANTILLA DEL TURNO NOCHE, TODOS COBRARÁN 315000

update PLANTILLA set SALARIO=315000
where TURNO = 'N';

select * from PLANTILLA;

rollback

-- MODIFICAR LA CIUDAD Y EL NOMBRE DEL DEPARTAMENTO 10.
-- SE LLAMARA CUENTAS Y NOS VAMOS A TOLEDO.

update DEPT set LOC='TOLEDO', DNOMBRE='CUENTAS'
where DEPT_NO=10;

select * from DEPT;

rollback

-- PODEMOS MANTENER EL VALOR DE UNA COLUMNA Y ASIGNAR ¨ALGO¨ CON OPERACIONES 
--MATEMATICAS.

-- INCREMENTAR EN 1 EL SALARIO DE TODOS LOS EMPLEADOS

update EMP set SALARIO=SALARIO + 1;

select * from EMP;

rollback



-- 1) SI LAS SUBCONSULTAS ESTAN EN EL SET, SOLAMENTE DEBEN DEVOLVER EL DATO

select * from EMP;

-- ARROYO ESTA ENVIDIOSO DE SALA, PONER EL MISMO SALARIO A ARROYO QUE SALA.

update EMP set SALARIO = (select SALARIO from EMP where APELLIDO='SALA')
where APELLIDO='ARROYO'


-- BAJAR EL SUELDO A LA MITAD A LOS CATALANES

update EMP set SALARIO=SALARIO /2
where DEPT_NO=(select DEPT_NO from DEPT where LOC='BARCELONA');

rollback;

select * from EMP







-- EJERCICIOS:


-- 1) Dar de alta con fecha actual al empleado José Escriche Barrera como 
--programador perteneciente al departamento de producción.  
--Tendrá un salario base de 70000 pts/mes y no cobrará comisión.

select * from EMP;

select * from DEPT;

insert into EMP (EMP_NO, FECHA_ALT, APELLIDO, OFICIO, SALARIO, COMISION, DEPT_NO) 
values ((select max (EMP_NO) + 1 from EMP), '31/01/2025', 'Barrera', 
'PROGRAMADOR', 70000, 0, (select DEPT_NO from DEPT where DNOMBRE='PRODUCCIÓN'))

SOLUCION: INSERT INTO EMP (APELLIDO, OFICIO, FECHA_ALT, SALARIO, COMISION, DEPT_NO) 
VALUES ('escriche', 'PROGRAMADOR', '28/10/2021' , 70000, 0, (SELECT DEPT_NO FROM DEPT WHERE DNOMBRE='PRODUCCION')) 

rollback

-- 2) Se quiere dar de alta un departamento de informática situado en 
--Fuenlabrada (Madrid).

insert into DEPT (DEPT_NO, DNOMBRE, LOC) values
((select max (DEPT_NO) + 1 from DEPT), 'INFORMÁTICA', 'FUENLABRADA')

SOLUCION 1: INSERT INTO DEPT 
VALUES(50, 'INFORMATICA','FUENLABRADA') 

SOLUCION 2: INSERT INTO DEPT 
VALUES((SELECT MAX(DEPT_NO) + 10 FROM DEPT), 'INFORMATICA','FUENLABRADA') 


-- 3) El departamento de ventas, por motivos peseteros, se traslada a Teruel, 
--realizar dicha modificación. 

update DEPT set LOC='TERUEL'
where DNOMBRE='VENTAS';

SOLUCION: UPDATE DEPT SET LOC='TERUEL' 
WHERE DNOMBRE='VENTAS' 

-- 4) En el departamento anterior (ventas), se dan de alta dos empleados: 
--Julián Romeral y Luis Alonso.  Su salario base es el menor que cobre un 
--empleado, y cobrarán una comisión del 15% de dicho salario.

select * from EMP;

select * from DEPT;

insert into EMP (EMP_NO, APELLIDO, SALARIO, COMISION, DEPT_NO) 
values ((select max (EMP_NO) + 1 from EMP), 'Romeral', 
(select min (SALARIO) from EMP), (select min (SALARIO) * 0.15 from EMP), 
(select DEPT_NO from DEPT where DNOMBRE='VENTAS'))

insert into EMP (EMP_NO, APELLIDO, SALARIO, COMISION, DEPT_NO) 
values ((select max (EMP_NO) + 1 from EMP), 'Alonso', 
(select min (SALARIO) from EMP), (select min (SALARIO) * 0.15 from EMP), 
(select DEPT_NO from DEPT where DNOMBRE='VENTAS'))

rollback

delete from EMP where APELLIDO='Alonso'

SOLUCION: INSERT INTO EMP (APELLIDO, SALARIO, COMISION, DEPT_NO) 
VALUES ('romeral', (SELECT MIN(SALARIO) FROM EMP WHERE OFICIO='EMPLEADO'),  
(SELECT MIN(SALARIO)*15/100 FROM EMP WHERE OFICIO='EMPLEADO') 
, (SELECT DEPT_NO FROM DEPT WHERE DNOMBRE='VENTAS')) 


INSERT INTO EMP (APELLIDO, SALARIO, COMISION, DEPT_NO) 
VALUES ('alonso', (SELECT MIN(SALARIO) FROM EMP WHERE OFICIO='EMPLEADO'),  
(SELECT MIN(SALARIO)*15/100 FROM EMP WHERE OFICIO='EMPLEADO') 
, (SELECT DEPT_NO FROM DEPT WHERE DNOMBRE='VENTAS')) 


-- 5) Modificar la comisión de los empleados de la empresa, de forma que todos 
--tengan un incremento del 10% del salario.

select * from EMP;

update EMP set SALARIO = SALARIO+(SALARIO*0.1) ;

SOLUCION: UPDATE EMP 
SET COMISION = SALARIO*10/100 

-- 6) Incrementar un 5% el salario de los interinos de la plantilla 
--que trabajen en el turno de noche. 

select * from PLANTILLA;

update PLANTILLA set SALARIO = SALARIO+(SALARIO*0.05)
where FUNCION='INTERINO' and TURNO='N'

SOLUCION: UPDATE PLANTILLA SET SALARIO = SALARIO*5/100 
WHERE FUNCION = 'INTERINO' AND TURNO ='N' 

rollback


-- 7) Incrementar en 5000 Pts. el salario de los empleados del departamento de 
--ventas y del presidente, tomando en cuenta los que se dieron de alta antes que
--el presidente de la empresa. 

select * from EMP;

update EMP set SALARIO = SALARIO + 5000
where OFICIO = 'PRESIDENTE' or DEPT_NO = (select DEPT_NO from DEPT where DNOMBRE='PRODUCCIÓN')

update EMP set SALARIO = (SALARIO + 5000)
where (select FECHA_ALT <= (select OFICIO = 'PRESIDENTE' from EMP) from EMP)

SOLUCION: UPDATE EMP 
SET SALARIO=SALARIO+5000 
WHERE OFICIO='PRESIDENTE' OR 
DEPT_NO=(SELECT DEPT_NO FROM DEPT WHERE DNOMBRE='VENTAS') 
AND FECHA_ALT<(SELECT FECHA_ALT FROM EMP WHERE OFICIO='PRESIDENTE') 


-- 8) El empleado Sanchez ha pasado por la derecha a un compañero. 
--Debe cobrar de comisión 12.000 ptas más que el empleado Arroyo y 
--su sueldo se ha incrementado un 10% respecto a su compañero. 

SOLUCION: UPDATE EMP SET COMISION = (SELECT COMISION + 12000 FROM EMP  
WHERE UPPER(APELLIDO) = 'ARROYO') , SALARIO =  (SELECT SALARIO * 1.10 FROM EMP  
WHERE UPPER(APELLIDO) = 'ARROYO') 
WHERE UPPER(APELLIDO) = 'SANCHA' 
 

-- 9) Se tienen que desplazar cien camas del Hospital SAN CARLOS para un 
--Hospital de Venezuela.  Actualizar el número de camas del Hospital SAN CARLOS.
;
select * from HOSPITAL;

update HOSPITAL set NUM_CAMA=(NUM_CAMA - 10)
where NOMBRE = 'san carlos';

SOLUCION: UPDATE HOSPITAL 
SET NUM_CAMA=NUM_CAMA-100 
WHERE NOMBRE='san carlos' 

-- 10) Subir el salario y la comisión en 100000 pesetas y veinticinco mil 
--pesetas respectivamente a los empleados que se dieron de alta en este año. 

select * from EMP;

update EMP set SALARIO=(SALARIO+100000), COMISION=(COMISION+25000)
where FECHA_ALT >= '01/01/2025';

SOLUCION: UPDATE EMP 
SET SALARIO= SALARIO+100000, COMISION=COMISION+25000 
WHERE FECHA_ALT>='01/01/2011' 

-- 11) Ha llegado un nuevo doctor a la Paz. Su apellido es House y su 
--especialidad es Diagnostico. Introducir el siguiente número de doctor 
--disponible. 

select * from DOCTOR
order by DOCTOR_NO;

insert into DOCTOR (DOCTOR_NO, APELLIDO, ESPECIALIDAD)
values ((select max (DOCTOR_NO)+1 from DOCTOR), 'House', 'Diagnostico')

SOLUCION: insert into doctor 
values  ((select hospital_cod from hospital 
where nombre='la paz') 
 , (select max(doctor_no) + 1 from doctor) 
 , 'House', 'Diagnostico') 

-- 12) Borrar todos los empleados dados de alta entre las fechas 01/01/80 y 
31/12/82. 
;
select * from EMP;

delete from EMP where FECHA_ALT >= '01/01/80' or FECHA_ALT <= '31/12/82'

SOLUCION: DELETE FROM EMP 
WHERE FECHA_ALT BETWEEN '01/01/1980' AND '31/12/1982' 

-- 13) Modificar el salario de los empleados trabajen en la paz y estén 
--destinados a Psiquiatría. Subirles el sueldo 20000 Ptas. más que al señor 
--Amigo R.
;
select * from PLANTILLA;

select * from HOSPITAL;

select * from DOCTOR;

update PLANTILLA set SALARIO = (SALARIO+20000)
where HOSPITAL_COD = (select HOSPITAL_COD from HOSPITAL where NOMBRE = 'la paz')
and where (select ESPECIALIDAD from DOCTOR where ESPECIALIDAD = 'Psiquiatria')

SOLUCION: UPDATE DOCTOR 
SET SALARIO = (SELECT SALARIO+20000 FROM PLANTILLA WHERE APELLIDO='amigo r.') 
WHERE HOSPITAL_COD = (SELECT HOSPITAL_COD FROM HOSPITAL WHERE NOMBRE='la paz') AND ESPECIALIDAD='Psiquiatria' 
 

14) Insertar un empleado con valores null (por ejemplo la comisión o el oficio),
-- y después borrarlo buscando como valor dicho valor null creado. 

INSERT INTO EMP 
(APELLIDO, SALARIO, COMISION, DEPT_NO) 
VALUES ('gutierrez', 225000, NULL, 10) 

DELETE FROM EMP 
WHERE OFICIO IS NULL AND COMISION IS NULL AND APELLIDO='gutierrez'; 

 
15) Borrar los empleados cuyo nombre de departamento sea producción. 


SOLUCION: DELETE FROM EMP 
WHERE DEPT_NO = (SELECT DEPT_NO FROM DEPT WHERE DNOMBRE='PRODUCCION') 

 

16) Borrar todos los registros de la tabla Emp de la forma más rápida. 

DELETE FROM EMP; 
TRUNCATE TABLE EMP; 













