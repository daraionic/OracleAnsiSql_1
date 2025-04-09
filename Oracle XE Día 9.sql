
---------------FUNCIONES EN ORACLE 

1.1  FUNCIONES DE FILTRO    


LOWER: Convierte a minúsculas las cadenas de caracteres mayúsculas o mixtas. 


UPPER: Convierte a mayúsculas las cadenas de caracteres minúsculas o mixtas. 


INITCAP: Convierte la primera letra de una cadena a mayúsculas y el resto a minúsculas 


select * from EMP where oficio='analista'; <<< Aquí no trae nada poque el oficio esta en mayus.

select * from EMP where LOWER(oficio)='analista'; <<< Aquí si aparecen porque 
estas forzando a que toda la columna oficio aparezca en minus, a pesar de que los 
valores estén en mayus.

--Estamos poneindo valores estaticos: 'analista'
--También podriamos incluir valores dinamicos por lo que tendriamos que convertir 
las dos comparaciones

update EMP set oficio ='analiSTA' where EMP_NO=7902;


select * from EMP where UPPER(OFICIO)=UPPER('&dato');

select * from EMP where UPPER(OFICIO)=UPPER('analista');


-- En Oracle tenemos la posibilidad de CONCATENAR TEXTOS EN UNA SOLA COLUMNA
--(CAMPO CALCULADO)

-- SE UTILIZA EL SIMBOLO || PARA CONCATENAR 

-- QUEREMOS MOSTRAR, EN UNA SOLA COLUMNA EL APELLIDO Y OFICIO DE LOS EMPLEADOS
;
select APELLIDO || OFICIO as DESCRIPCION from EMP;

select APELLIDO || ' ' || OFICIO as DESCRIPCION from EMP;


-- LA FUNCION INITCAP MUESTRA CADA PALABRA DE UNA FRASE CON LA PRIMRA LETRA EN MAYUS

select INITCAP (OFICIO) as INITC from EMP;

select INITCAP (APELLIDO || ' ' || OFICIO) as DESCRIPCION from EMP;


select concat ('Nuestro empleado ES...', APELLIDO) as RESULTADO from EMP;



-- substr RECUPERA UNA SUBCADENA DE UN TEXTO

select SUBSTR ('FLORERO', 1, 4) as DATO from DUAL;

select SUBSTR ('FLORERO', 2, 4) as DATO from DUAL;

select SUBSTR ('FLORERO', 4) as DATO from DUAL;

select SUBSTR ('FLORERO', 2, 40) as DATO from DUAL;


-- MOSTRAR LOS EMPLEADOS CUYO APELLIDO COMIENZA POR S

select * from EMP where APELLIDO like 's%';

select substr (APELLIDO, 1, 1) as UNALETRA from EMP;

select * from EMP where substr(APELLIDO, 1, 1)='s';


-- MOSTRAR LOS EMPLEADOS CUYO APELLIDO SEA DE 4 LETRAS

select * from EMP where APELLIDO like '____';

select * from EMP where length(APELLIDO)=4;


-- INSTR BUSCA UN TEXTO Y DEVUELVE SU POSICIÓN

select INSTR('BENITO', 'NI') as POSICION from DUAL;

select INSTR('BENITO', 'NIP') as POSICION from DUAL; < DEVUELVE 0 PORQUE NO EXISTE

select INSTR('ORACLE MOLA','L') as POSICION from DUAL;

select INSTR('ORACLE MOLA',' ') as POSICION from DUAL;

-- SI DESEAMOS VALIDAR UN MAIL

select * from DUAL where INSTR ('m@il', '@')>0;


-- LPAD o RPAD pone la cantidad de caracteres a la izquierda o derecha que queramos

select LPAD(DEPT_NO,5,'$') from EMP;

select RPAD(DEPT_NO,5,'$') from EMP;




--- FUNCIONES MATEMATICAS

select ROUND (45.923) as REDONDEO from DUAL;

select ROUND (45.423) as REDONDEO from DUAL;

select ROUND (45.423, 2) as REDONDEO from DUAL;

select ROUND (45.463, 2) as REDONDEO from DUAL;


select TRUNC (45.923) as REDONDEO from DUAL;

select TRUNC (45.423) as REDONDEO from DUAL;

select TRUNC (45.423, 2) as REDONDEO from DUAL;

select TRUNC (45.463, 2) as REDONDEO from DUAL;


--- RESTO
-- AVERIGUAR SI EL NUMERO ES PAR

select MOD (99, 2) as RESTO from DUAL;

select MOD (8, 2) as RESTO from DUAL;

select MOD (9, 2) as RESTO from DUAL;

--MOSTRAR LOS EMPLEADOS CUYO SALARIO SEA PAR

select * from EMP;

update EMP set SALARIO = SALARIO + 1 where DEPT_NO=20;

select * from EMP where MOD(SALARIO,2)=0;

select * from EMP where MOD(SALARIO,2)=1;

--Calcular el resto resultante de dividir el salario a la comisión para todos los empleados cuyo oficio es VENDEDOR, 

 

SELECT MOD(SALARIO, COMISION) as RESTO 

FROM EMP 

WHERE OFICIO ='VENDEDOR'; 




---- 3.  FUNCIONES  DE  FECHAS.  

-- TENEMOS UNA FUNCION PARA AVERIGAR LA FECHA ACTUAL DE HOY
-- EN EL SERVIDOR: sysdate

select SYSDATE as FECHA_ACTUAL from DUAL;

select '08/04/2025'+10 as FECHA from DUAL; ERROR PORQUE TOMA FORMATO TEXTO

select SYSDATE+10 as FECHA from DUAL;

select SYSDATE+30 as FECHA from DUAL;

select SYSDATE-10 as FECHA from DUAL;

select SYSDATE-1824687 as FECHA from DUAL;



-- MOSTRAR CUANTOS MESES LLEVAN DADOS DE ALTA EN LA EMPRESA

select APELLIDO, MONTHS_BETWEEN (SYSDATE, FECHA_ALT) as MESES from EMP;


-- AGREGAMOS A LA FECHA ACTUAL, 5 MESS

select add_months (SYSDATE, 5) as DENTRO5 from DUAL;


-- MOSTRAR CUANDO ES EL PROXIMO LUNES

select next_day (SYSDATE, 'LUNES') as PROXIMOLUNES from DUAL;

select next_day (SYSDATE, 'martes') as PROXIMOLUNES from DUAL;

select next_day (SYSDATE, 'miércoles') as PROXIMOLUNES from DUAL;


-- LAST_DAY

select LAST_DAY(SYSDATE)-3 AS FINMES FROM DUAL;

-- ROUND 

-- EMPELADOS REDONDEADOS LA FECHA AL MES

select APELLIDO, FECHA_ALT, ROUND(FECHA_ALT, 'MM') as ROUNDMES from EMP;

select APELLIDO, FECHA_ALT, ROUND(FECHA_ALT, 'YY') as ROUNDYES from EMP;


-- TRUNC FECHA
-- TRUNC: Trunca la fecha dependiendo del formato. Redondea siempre a 01-xx-xx 
cuando es MM, y a 01-01-xx cuando es YY.  

select APELLIDO, FECHA_ALT, TRUNC(FECHA_ALT, 'MM') as TRUNCMES from EMP;

select APELLIDO, FECHA_ALT, TRUNC(FECHA_ALT, 'YY') as TRUNCMES from EMP;




---- 4. FUNCIONES DE CONVERSIÓN. 

TO_CHAR: Convierte datos de tipo DATE o NUMBER a cadenas de caracteres. 
Se suele utilizar para visualizar las fechas o valores numéricos en un formato 
diferente a como están almacenadas en la base de datos.  

Sintaxis: 

TO_CHAR(fecha,’formato’); 

TO_CHAR(número,’formato’); 

select APELLIDO, FECHA_ALT, TO_CHAR(FECHA_ALT, 'MM-DD-YYYY') as FORMATO from EMP;

select APELLIDO, FECHA_ALT, TO_CHAR(FECHA_ALT, 'MM@DD@YYYY') as FORMATO from EMP;

select TO_CHAR(SYSDATE,'day MONTH')as NOMBREMES fRom DUAL;

select TO_CHAR(SYSDATE,'day MONTH ww')as NOMBREMES fRom DUAL;


-- formato a numeros

select TO_CHAR (7458,'0000L') as ZERO from DUAL;

select TO_CHAR (7458,'0000$') as ZERO from DUAL;


-- HORA DEL SISTEMA

select TO_CHAR (SYSDATE, 'HH24:MI:SS') as HORA_SISTEMA from DUAL;


-- SI DESEAMOS INCLUIR TECTO ENTRE TO_CHAR Y LOS FORMATOS SE RALIZA CON " " DENTRO
DE LAS SIMPLES

select TO_CHAR (SYSDATE, '"Hoy es" DD "de" MONTH') as FORMATO from DUAL;

select TO_CHAR (SYSDATE, '"Hoy es" DD "de" MONTH', 'nls_date_language = FRENCH') 
as FORMATO from DUAL;




-- FUNCIONES DE CONVERSION 2:

select '08/04/2025' as FECHA from DUAL;

select TO_DATE('08/04/2025') as FECHA from DUAL;

select '08/04/2025'+2 as FECHA from DUAL; ERROR POR FORMATO FECHA PERO SE PODRIA ASI:

select TO_DATE('08/04/2025')+2 as FECHA from DUAL;


select '12' +2 as RESULTADO from DUAL;

select TO_NUMBER('12') +2 as RESULTADO from DUAL;



--- 5.  FUNCIONES GENERALES 

-- NVL SIRVE PARA EVITAR LOS NULOS Y SUSTITUIR

-- SI ENCUENTRA UN NULO, LO SUSTITUYE, SINO, MUESTRA EL VALOR

select * from EMP;

-- mostrar apellido, salario y comision de todos los EMP

select APELLIDO, SALARIO, COMISION from EMP;

-- PODEMOS INDICAR QUE EN LUGAR DE PONER NULL, ESCRIBA OTRO VALOR

-- EL VALOR DEBE SER CORRESPONDIENTE AL TIPO DE DATO DE LA COLUMNA

select APELLIDO, SALARIO, nvl(COMISION, -1) as COMISION from EMP;

-- MOSTRAR APELLIDO, SALARIO + COMISION DE TODOS LOS EMPLEADOS

select APELLIDO, SALARIO + COMISION as total from EMP; hay campos con null

select APELLIDO, SALARIO + nvl(COMISION, 0) as total from EMP, ya no hay null


-- MOSTRAR EL TURNO EN PALABRA ('MAÑANA', 'TARDE' O 'NOCHE') DE LA PLANTILLA

select APELLIDO, TURNO from PLANTILLA;

select APELLIDO, decode(TURNO, 'M', 'MAÑANA', 'T', 'TARDE', 'N', 'NOCHE') as TURNO 
from PLANTILLA;


---- 6. FUNCIONES ANIDADAS 

-- QUIERO SABER LA FECHA DEL PROXIMO MIERCOLES QUE JUEGA EL MADRID
--quiero ver la fecha completa
--quiero ver: El Miercoles 09 de abril juega el Madrid

select to_char( 
next_day(sysdate+2,'miércoles'),
'"El día " DAY dd "juega el Madrid"') as CHAMPIONS from DUAL;


select apellido, oficio, dnombre, loc
from EMP
natural join DEPT;