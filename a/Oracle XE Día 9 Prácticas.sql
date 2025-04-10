------ 02 - CONSULTAS CON FUNCIONES

1) Mostrar todos los apellidos de los empleados en Mayúsculas 

select UPPER (APELLIDO) from EMP;

2) Construir una consulta para que salga la fecha de hoy con el siguiente formato: 
 FECHA DE HOY 

----------------------------------------- 

Martes 06 de Octubre de 2020 

select sysdate as fecha_actual from DUAL;

select TO_CHAR (SYSDATE, 'DAY WW "de" MONTH"de" YYYY', 'nls_date_language = SPANISH') as FORMATO from DUAL;

Ahora en Italiano: 

FECHA DE HOY 

---------------------------------- 

MARTEDI   06 de  OTTOBRE   de 2020 

select TO_CHAR (SYSDATE, 'DAY DD "de" MONTH"de" YYYY', 'nls_date_language = ITALIAN') as FORMATO from DUAL;


3) Queremos cambiar el departamento de Barcelona y llevarlo a Tabarnia. 

Para ello tenemos que saber qué empleados cambiarían de localidad y cuáles no.   

Combinar tablas y mostrar el nombre del departamento junto a los datos del empleado. 

select * from DEPT;

select * from EMP order by FECHA_ALT;

select DNOMBRE, EMP_NO, APELLIDO, decode(LOC, 'BARCELONA', 'A TABARNIA', 'NO SE CAMBIA DE LOCALIDAD') as TRANSLADO
from EMP
inner join DEPT
on EMP.DEPT_NO=DEPT.DEPT_NO;



4) Mirar la fecha de alta del presidente. Visualizar todos los empleados dados de alta 330 días antes que el presidente.  

select FECHA_ALT from EMP where OFICIO='PRESIDENTE';


select APELLIDO, FECHA_ALT, FECHA_ALT-330 as FECHA_ALTA_330 from EMP;



select APELLIDO, FECHA_ALT from EMP where FECHA_ALT <= (select FECHA_ALT-330 from EMP where OFICIO='PRESIDENTE') ;



5) Nos piden un informe como este: 

Informe 

-------------- -------------- -------------- -------------- -------------- 

Rey........... Presidente.... 650000........ ........       10............ 

Negro......... Director...... 370500........ ........       30............ 

Jimenez....... Director...... 386750........ ........       20............ 

Cerezo........ Director...... 318500........ ........       10............ 

Arroyo........ Vendedor...... 208000........ ........       30............ 

Sala.......... Vendedor...... 162500........ ........       30............ 

Martín........ Vendedor...... 162500........ ........       30............ 

Tovar......... Vendedor...... 195000........ ........       30............ 

Jimeno........ Empleado...... 123500........ ........       10............ 

Fernández..... Analista...... 390000........ ........       20............ 

Gil........... Analista...... 390000........ ........       20............ 

Sánchez....... Empleado...... 104000........ ........       20............ 

Alonso........ Empleado...... 143000........ ........       20............ 

Múñoz......... Empleado...... 169000........ ........       10............ 


SELECT RPAD(INITCAP(APELLIDO), 12, '.') AS INFORME, RPAD(INITCAP(OFICIO), 12, '.') AS " " , RPAD(SALARIO, 12, '.') AS " " , RPAD(DEPT_NO, 5, '.') AS " " FROM EMP; 




6) Nos piden otro, en el que se muestren todos los empleados de la siguiente manera: 

fechas de alta 

------------------------------------------------------------------------------ 

El Señor Tovar con cargo de Vendedor se dió de alta el jueves  11 de noviembre  de 2095 en la empresa 
. 
. 
. 
. 

SELECT 'El señor/a ' || INITCAP(APELLIDO) || ' con cargo de ' || INITCAP(OFICIO) || ' se dio de alta el ' 
|| TO_CHAR(FECHA_ALT, 'day dd "de" month "de" yyyy') || ' en la empresa.' AS INFORME FROM EMP; 
 