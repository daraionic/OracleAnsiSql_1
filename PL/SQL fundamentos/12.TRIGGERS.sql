----------------------------- 12. TRIGGERS ----------------------

-- ejemplo de trigger capturando información
drop trigger tr_dept_before_insert
create or replace trigger tr_dept_before_insert
before insert
on DEPT
for each ROW
DECLARE
BEGIN
    dbms_output.put_line ('Trigger DEPT before insert row');
    dbms_output.put_line (:new.DEPT_NO || ', ' || :new.DNOMBRE || ', ' || :new.LOC);
end;

insert into DEPT values (111, 'NUEVO', 'TOLEDO');


-- delete
drop trigger tr_dept_before_delete
create or replace trigger tr_dept_before_delete
before delete
on DEPT
for each ROW
DECLARE
BEGIN
    dbms_output.put_line ('Trigger DEPT before delete row');
    dbms_output.put_line (:old.DEPT_NO || ', ' || :old.DNOMBRE || ', ' || :old.LOC);
end;

delete from DEPT where DEPT_NO = 47;

select * from DEPT;


-- update
drop trigger tr_dept_before_update
create or replace trigger tr_dept_before_update
before update
on DEPT
for each ROW
DECLARE
BEGIN
    dbms_output.put_line ('Trigger DEPT before update row');
    dbms_output.put_line (:old.DEPT_NO || ', Antigua LOC: ' || :old.LOC || ', Nueva LOC: ' || :new.LOC);
end;

update DEPT set LOC='VICTORIA' where DEPT_NO=51;



--- TRIGGER CONTROL DOCTOR
drop trigger tr_doctor_control_salario_update
create or replace trigger tr_doctor_control_salario_update
before update
on DOCTOR
for each ROW
DECLARE
BEGIN
    dbms_output.put_line ('Trigger DOCTOR before update row');
    dbms_output.put_line ('Dr/Dra ' || :old.APELLIDO || ' cobra mucho dinero: ' || :new.SALARIO || '. Antes: ' || :old.SALARIO);
end;

update DOCTOR set SALARIO = 150000 where DOCTOR_NO = 386;

create or replace trigger tr_doctor_control_salario_update
before update
on DOCTOR
for each ROW
    when (new.SALARIO > 250000)
DECLARE
BEGIN
    dbms_output.put_line ('Trigger DOCTOR before update row');
    dbms_output.put_line ('Dr/Dra ' || :old.APELLIDO || ' cobra mucho dinero: ' || :new.SALARIO || '. Antes: ' || :old.SALARIO);
end;

update DOCTOR set SALARIO = 20000 where DOCTOR_NO = 386; (--Se actualiza pero sin el trigger porque no cumple la funcion)

update DOCTOR set SALARIO = 25654460000 where DOCTOR_NO = 386; (--Se actualiza y con trigger porque cumple la funcion)


--- NO PODEMOS TENER DOS TRIGGERS DEL MISMO TIPO EN UNA TABLA

drop trigger tr_dept_control_barcelona

create or replace trigger tr_dept_control_barcelona
before insert
on DEPT
for each ROW
DECLARE
BEGIN
    dbms_output.put_line ('Trigger Control Barcelona');
    if (upper(:new.LOC) = 'BARCELONA') then
        dbms_output.put_line ('No se adminten departamentos en Barcelona');
        raise_application_error (-20001, 'En Munich solo ganadores');
    end if;
end;

insert into DEPT values (5, 'MILAN', 'BARCELONA');

select * from DEPT;


-- IGUAL QUE EL DE ARRIBA PERO MAS EFICIENTE PORQUE SOLO LEE EL CODIGO CUANDO CUMPLE LA CONDICION, NO COMO EL ANTERIOR
--QUE LEE TODAS LAS LINEAS.
drop trigger tr_dept_control_barcelona
create or replace trigger tr_dept_control_barcelona
before insert
on DEPT
for each ROW
    when (upper(new.LOC) = 'BARCELONA')
DECLARE
BEGIN
    dbms_output.put_line ('Trigger Control Barcelona');
    dbms_output.put_line ('No se adminten departamentos en Barcelona');
    raise_application_error (-20001, 'En Munich solo ganadores');
end;

insert into DEPT values (5, 'MILAN', 'aaa');


---
drop trigger tr_dept_control_localidades
create or replace trigger tr_dept_control_localidades
before insert
on DEPT
for each ROW
DECLARE
    v_num number;
BEGIN
    dbms_output.put_line ('Trigger Control Localidades');
    select count (DEPT_NO) into v_num from DEPT
    where UPPER(LOC)=UPPER(:new.loc);
    if (v_num > 0) then
        raise_application_error (-20001, 'Solo un departamento por ciudad ' || :new.LOC);
    end if;
end;

insert into DEPT values (65, 'MILAN', 'TERUEL'); (-- UNO EN TERUEL DEJARÁ PERO YA NO MÁS QUE OTRO)


-- 
drop trigger tr_dept_control_localidades
create or replace trigger tr_dept_control_localidades
before insert
on DEPT
for each ROW
DECLARE
    v_num number;
BEGIN
    dbms_output.put_line ('Trigger Control Localidades');
    select count (DEPT_NO) into v_num from DEPT
    where UPPER(LOC)=UPPER(:new.loc);
    if (v_num > 0) then
        raise_application_error (-20001, 'Solo un departamento por ciudad ' || :new.LOC);
    end if;
end;

insert into DEPT values (65, 'MILAN', 'TERUEL'); (-- UNO EN TERUEL DEJARÁ PERO YA NO MÁS QUE OTRO)


-- EJEMPLO INTEGRIDAD RELACIONAL CON UPDATE

-- SI CAMBIAMOS UN ID DE DEPARTAMENTO QUE SE MODIFIQUEN TAMBIEN LOS EMPLEADOS ASOCIADOS
drop trigger tr_update_dept_cascade
create or replace trigger tr_update_dept_cascade
before update
on DEPT
for each row
    when (new.DEPT_NO <> old.DEPT_NO)
declare
begin
    dbms_output.put_line ('DEPT_NO cambiando');
    -- modificamos los datos asociados (EMP)
    update EMP set DEPT_NO = :new.DEPT_NO where DEPT_NO = :old.DEPT_NO;
end;

update DEPT set DEPT_NO=31 where DEPT_NO=30;

update DEPT set LOC = 'ZARAGOZA' where DEPT_NO = 30;

select * from emp;


-- Impedir insertar un nuevo presidente si ya existe en la tabla EMP.
drop trigger tr_presidente_insert
create or replace trigger tr_presidente_insert
before insert on EMP
for each row
    when (upper(new.oficio) = 'PRESIDENTE')
declare
    v_presis int;
begin
    select count (emp_no) into v_presis from EMP
    where upper(OFICIO) = 'PRESIDENTE';
    dbms_output.put_line ('Presis ' || v_presis);
    if (v_presis > 0) then
        raise_application_error (-20001, 'Existe mas de un presidente en la tabla');
    end if;
end;

insert into emp values (1114, 'REINA', 'PRESIDENTE', null, sysdate, 750000, 0, 10); 



---

drop trigger tr_dept_control_localidades
create or replace trigger tr_dept_control_localidades
before update -- VAMOS A COMPROBAR ANTES DEL UPDATE
on DEPT
for each ROW
DECLARE
    v_num number;
BEGIN
    dbms_output.put_line ('Trigger Control Localidades');
    select count (DEPT_NO) into v_num from DEPT
    where UPPER(LOC)=UPPER(:new.loc);
    if (v_num > 0) then
        raise_application_error (-20001, 'Solo un departamento por ciudad ' || :new.LOC);
    end if;
end;


--PACKAGE PARA ALMACENAR LAS VARIABLES ENTRE TRIGGERS

create or replace package PK_TRIGGERS
as
    v_nueva_localidad DEPT.LOC%TYPE;
end PK_TRIGGERS;

create or replace trigger tr_dept_control_localidades_row
before update --VAMOS A COMPROBAR ANTES DE UPDATE
on DEPT
for each row
declare
begin
    dbms_output.PUT_LINE('For each ROW ');    
    --almacenamos el valor de la nueva localidad
    PK_TRIGGERS.v_nueva_localidad := :new.LOC;
end;

drop trigger tr_dept_control_localidades_after;

--creamos el trigger de update para after
create or replace trigger tr_dept_control_localidades_after
after update
on DEPT
declare
begin
    dbms_output.PUT_LINE('Localidad nueva: ' || PK_TRIGGERS.v_nueva_localidad);
end;

update DEPT set LOC='CADIZ' where DEPT_NO=10;

??????????????????????????????

-- creamos una vista con todos los datos de los departamentos

create or replace view vista_departamentos
as
    select * from DEPT;

--- SOLO TRABAJAMOS CON LA VISTA

insert into VISTA_DEPARTAMENTOS values (11, 'VISTA', 'SIN TRIGGER');

-- CREAMOS UN TRIGGER SOBRE LA VISTA

create or replace trigger tr_vista_dept
instead of insert
on vista_departamentos
declare
begin
    dbms_output.put_line ('Insertando en ')
end;



-- VAMOS A CREAR UNA VISTA CON LOS DATOS DE LOS EMPLEADOS PERO SIN SUS DATOS SENSIBLES QUE SON SALARIO, COMISION Y FECHA ALTA

create view vista_empleaditos
as
    select EMP_NO, APELLIDO, OFICIO, DIR, DEPT_NO from EMP;
/
select * from vista_empleaditos;
/
insert into vista_empleaditos values (555, 'EL NUEVO', 'BECARIO', 7566, 31);
--- SI MIRAMOS EN LA TABLA....
select * from EMP order by EMP_NO; 


create or replace trigger tr_vista_empleados
instead of INSERT
on vista_empleaditos
declare
begin
    -- con new capturamos los datos que vienen en la vista y rellenamos el resto
    insert into EMP values (:new.EMP_NO, :new.APELLIDO, :new.OFICIO, :new.DIR, sysdate, 0, 0, :new.DEPT_NO);
end;

rollback;
