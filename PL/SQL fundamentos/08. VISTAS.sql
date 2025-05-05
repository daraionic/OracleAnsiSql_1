--------------------- 08. VISTAS ---------------------

-- Vamos a crear una vista paa tener todos los datos de los emplados sin el salario ni comisión, ni dir.

create or replace view V_EMPLEADOS
as
    select EMP_NO, APELLIDO, OFICIO, FECHA_ALT, DEPT_NO from EMP;

select * from V_EMPLEADOS;

-- UNA VISTA SIMPLICA LAS CONSULTAS

-- MOSTRAR EL EMP ID, APELLIDO, OFICIO, SALARIO, NOMBRE DEPTO Y LOCALIDAD DE LOS SP_EMPLEADOS_DEPT

create or replace view V_EMP_DEPT
as
    select EMP.EMP_NO, EMP.APELLIDO, EMP.OFICIO, EMP.SALARIO, DEPT.DNOMBRE, DEPT.LOC
    from EMP
    inner join DEPT
    on EMP.DEPT_NO = DEPT.DEPT_NO;

select * from V_EMP_DEPT where LOC = 'MADRID';


-- PODEMOS TENER CAMPOS VIRTUALES EN UNA VISTA

create or replace view V_EMPLEADOS_VIRTUAL
as
    select EMP_NO, APELLIDO, OFICIO, SALARIO + COMISION as TOTAL, DEPT_NO from EMP;

select * from V_EMPLEADOS_VIRTUAL where OFICIO = 'ANALISTA';

-- MODIFICAR EL SALARIO DE LOS EMPLEADOS ANALISTA
-- tabla

update EMP set SALARIO = SALARIO +1 where OFICIO = 'ANALISTA';


-- vista

create or replace view V_EMPLEADOS_CON_SALARIO
as
    select EMP_NO, APELLIDO, OFICIO, SALARIO, FECHA_ALT, DEPT_NO from EMP;

update V_EMPLEADOS_CON_SALARIO set SALARIO = SALARIO + 1 where OFICIO = 'ANALISTA';

select * from V_EMPLEADOS_CON_SALARIO;

-- Eliminamos al empleado con ID 7917

delete from V_EMPLEADOS where EMP_NO = 7917;

select * from EMP;


-- INSERTAMOS EN LA VISTA

insert into V_EMPLEADOS_CON_SALARIO values (111,'lunes', 'LUNES', 0, sysdate, 40);


-- Modificamos el salario de los emplados de Madrid

update V_EMP_DEPT set SALARIO = SALARIO +1 where LOC = 'MADRID';

-- Eliminar a los empleados de Barcelona

delete from V_EMP_DEPT where LOC = 'BARCELONA';

ROLLBACK;


-- NO DEJA MODIFICAR MAS DE UNA TABLA A LA VEZ:

insert into V_EMP_DEPT values (3333,'lunes 3', 'LUNES 3', 250000, 'CONTABILIAD', 'SEVILLA');

--00000 -  "cannot mofify more than one base table through a join view"




-- VISTAS QUE PUEDEN LLEGAR A SER INUTILES

create or replace view V_VENDEDORES
as
    select EMP_NO, APELLIDO, SALARIO, DEPT_NO, OFICIO from EMP
    where OFICIO = 'VENDEDOR'
    with check option;
    
select * from V_VENDEDORES;

-- MODIFICAR EL SALARIO DE LOS VENDDEORES

update V_VENDEDORES set SALARIO = SALARIO + 1;

update V_VENDEDORES set OFICIO = 'VENDIDOS';



