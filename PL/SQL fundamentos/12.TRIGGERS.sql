----------------------------- 12. TRIGGERS ----------------------

-- ejemplo de trigger capturando información

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

drop trigger tr_dept_before_insert;

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

