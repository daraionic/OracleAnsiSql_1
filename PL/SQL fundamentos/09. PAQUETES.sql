---------------- 09. PAQUETES ----------------

-- CREAMOS NUESTRO PRIMER PACKAGE DE PRUBA
-- HEADER

create or replace package pk_ejemplo
as
    -- en el header solamente se incluyen las declaraciones
    procedure mostrarmensaje;
end pk_ejemplo;

-- BODY

create or replace package body pk_ejemplo
as
    -- en el header solamente se incluyen las declaraciones
    procedure mostrarmensaje
    as
    begin
        dbms_output.put_line ('Soy un paquete');
    end;
end pk_ejemplo;

-- llamada

begin
    pk_ejemplo.mostrarmensaje;
end;




-- Vamos a realizar un paquete que contenga acciones de eliminar sobre EMP, DEPT, DOCTOR, ENFERMO

create or replace package pk_delete
as
    procedure eliminarempleado (p_empno EMP.EMP_NO%TYPE);
    procedure eliminardepartamento (p_deptno DEPT.DEPT_NO%TYPE);
    procedure eliminardoctor (p_doctorno DOCTOR.DOCTOR_NO%TYPE);
    procedure eliminarenfermo (p_inscripcion ENFERMO.INSCRIPCION%TYPE);
end pk_delete;


--body

create or replace package body pk_delete
as
    procedure eliminarempleado (p_empno EMP.EMP_NO%TYPE)
    as
    begin
        delete from EMP where EMP_NO = p_empno;
        commit;
    end;
    procedure eliminardepartamento (p_deptno DEPT.DEPT_NO%TYPE)
    as
    begin
        delete from DEPT where DEPT_NO = p_deptno;
        commit;
    end;
    procedure eliminardoctor (p_doctorno DOCTOR.DOCTOR_NO%TYPE)
    as
    begin
        delete from DOCTOR where DOCTOR_NO = p_doctorno;
        commit;
    end;
    procedure eliminarenfermo (p_inscripcion ENFERMO.INSCRIPCION%TYPE)
    as
    begin
        delete from ENFERMO where INSCRIPCION = p_inscripcion;
        commit;
    end;
end pk_delete;

select * from DEPT;

begin
    pk_delete.eliminardepartamento (43);
end;

-- SI ESTAMOS DENTRO DEL PAQUETE SOLO ELIMINAMOS CON EL NOMBRE, SI ES UNA LLAMADA (COMO ARRIBA) TENEMOS QUE PONER EL NOMBRE DEL PAQUETE





-- CREAR UN PAQUETE PARA DEVOLVER MAXIMO, MINIMO Y DIFERENCIA DE TODOS LOS EMPLEADOS (SALARIO)

create or replace package pk_empleados_salarios
as
    function minimo return number;
    function maximo return number;
    function diferencia return number;
end pk_empleados_salarios;

-- body

create or replace package body pk_empleados_salarios
as
    function minimo return number
    as
        v_minimo EMP.SALARIO%TYPE;
    begin
        select min(SALARIO) into v_minimo from EMP;
        return v_minimo;
    end;
    function maximo return number
    as
        v_maximo EMP.SALARIO%TYPE;
    begin
        select max(SALARIO) into v_maximo from EMP;
        return v_maximo;
    end;
    function diferencia return number
    as
        v_diferencia EMP.SALARIO%TYPE;
    begin
        v_diferencia := maximo - minimo;
        return v_diferencia;
    end;
end pk_empleados_salarios;

select pk_empleados_salarios.MAXIMO as MAXIMO, pk_empleados_salarios.MINIMO as MINIMO, pk_empleados_salarios.DIFERENCIA from dual;



--- Necesito un paquete para realizar
--- update, insert y delete sobre departamentos
--- llamamos al paquete pk_departamentos

select * from dept;


create or replace package pk_departamentos
as
    procedure updatedepartamento (p_updatedept_no DEPT.DEPT_NO%TYPE, p_updatednombre DEPT.DNOMBRE%TYPE, p_updateloc DEPT.LOC%TYPE);
    procedure insertdepartamento (p_insertdept_no DEPT.DEPT_NO%TYPE, p_insertdnombre DEPT.DNOMBRE%TYPE, p_insertloc DEPT.LOC%TYPE);
    procedure deletedepartamento (p_deletedept DEPT.DEPT_NO%TYPE);
end pk_departamentos;

create or replace package body pk_departamentos
as
    procedure updatedepartamento (p_updatedept_no DEPT.DEPT_NO%TYPE, p_updatednombre DEPT.DNOMBRE%TYPE, p_updateloc DEPT.LOC%TYPE)
    as
    begin
        update DEPT set DNOMBRE = p_updatednombre, LOC = p_updateloc where DEPT_NO = p_updatedept_no;
        commit;
    end;
    procedure insertdepartamento (p_insertdept_no DEPT.DEPT_NO%TYPE, p_insertdnombre DEPT.DNOMBRE%TYPE, p_insertloc DEPT.LOC%TYPE)
    as
    begin
        insert into DEPT values (p_insertdept_no, p_insertdnombre, p_insertloc);
        commit;
    end;
    procedure deletedepartamento (p_deletedept DEPT.DEPT_NO%TYPE)
    as
    begin
        delete from DEPT where DEPT_NO = p_deletedept;
        commit;
    end;
end pk_departamentos;

select * from dept;

begin
    pk_departamentos.updatedepartamento (41, 'MOVILES', 'BUENOS AIRES');
    pk_departamentos.insertdepartamento (99, 'PAQUETES', 'A CORUNA');
    pk_departamentos.deletedepartamento (54);
end;



-- Necesito una funcionalidad que nos devuelva el Apellido, el trabajo y lugar de trabajo (departamento/hospital) de todas las personas de la BBDD.

-- Necesito otra funcionalidad que nos devuelva el Apellido, el trabajo y lugar de trabajo (departamento/hospital) dependiendo del salario.


-- 1) select uniendo tablas

-- 2) meter la consulta en una vista

-- 3) paquete de procedimientos

-- 3A) procedimientos para devolver todos los datos en un cursor

-- 3B) procedimientos para devolver todos los datos en un cursor por salario


select EMP.APELLIDO, EMP.OFICIO, EMP.SALARIO, DEPT.DNOMBRE from EMP inner join DEPT on EMP.DEPT_NO = DEPT.DEPT_NO
union
select PLANTILLA.APELLIDO, PLANTILLA.FUNCION, PLANTILLA.SALARIO, HOSPITAL.NOMBRE from PLANTILLA inner join HOSPITAL on PLANTILLA.HOSPITAL_COD = HOSPITAL.HOSPITAL_COD
union
select DOCTOR.APELLIDO, DOCTOR.ESPECIALIDAD, DOCTOR.SALARIO, HOSPITAL.NOMBRE from DOCTOR inner join HOSPITAL on DOCTOR.HOSPITAL_COD = HOSPITAL.HOSPITAL_COD;


create or replace view V_TODOS
as
    select EMP.APELLIDO, EMP.OFICIO, EMP.SALARIO, DEPT.DNOMBRE from EMP inner join DEPT on EMP.DEPT_NO = DEPT.DEPT_NO
    union
    select PLANTILLA.APELLIDO, PLANTILLA.FUNCION, PLANTILLA.SALARIO, HOSPITAL.NOMBRE from PLANTILLA inner join HOSPITAL on PLANTILLA.HOSPITAL_COD = HOSPITAL.HOSPITAL_COD
    union
    select DOCTOR.APELLIDO, DOCTOR.ESPECIALIDAD, DOCTOR.SALARIO, HOSPITAL.NOMBRE from DOCTOR inner join HOSPITAL on DOCTOR.HOSPITAL_COD = HOSPITAL.HOSPITAL_COD;


select * from V_TODOS;


create or replace package pk_vista_empleados
as
    procedure todos_empleados;
    procedure todos_empleados_salario(p_salario EMP.SALARIO%TYPE);
end pk_vista_empleados;


create or replace package body pk_vista_empleados
as
    procedure todos_empleados
    as
        cursor c_empleados IS
        select * from V_TODOS;
    begin
        for v_emp in c_empleados
        loop
            dbms_output.put_line (v_emp.APELLIDO || 
            ', Oficio: ' || v_emp.OFICIO ||
            ', Salario: ' || v_emp.SALARIO ||
            ', Lugar: ' || v_emp.DNOMBRE);
        end loop;
    end;
    procedure todos_empleados_salario (p_salario EMP.SALARIO%TYPE)
    as
        cursor c_empleados IS
        select * from V_TODOS
        where SALARIO >= p_salario;
    begin
        for v_emp in c_empleados
        loop
            dbms_output.put_line (v_emp.APELLIDO || 
            ', Oficio: ' || v_emp.OFICIO ||
            ', Salario: ' || v_emp.SALARIO ||
            ', Lugar: ' || v_emp.DNOMBRE);
        end loop;
    end;
end pk_vista_empleados;


begin
    PK_VISTA_EMPLEADOS.TODOS_EMPLEADOS;
end;


begin
    PK_VISTA_EMPLEADOS.TODOS_EMPLEADOS_SALARIO(350000);
end;





--Necesitamos un paquete con procedimiento para modificar el salario de cada Doctor de forma individual.
--La modificación de los datos de cada doctor será de forma aleatoria.
--Debemos comprobar el Salario de cada Doctor para ajustar el número aleatorio del incremento.
--1) Doctor con menos de 200.000: Incremento aleatorio de 500
--2) Doctor entre de 200.000 y 300.000: Incremento aleatorio de 300
--3) Doctor mayor a 300.000: Incremento aleatorio de 50
--El incremento Random lo haremos con una función dentro del paquete.
update doctor set salario = salario + dbms_random.value(1,50);
select dbms_random.value(1,50) from DUAL;
select * from DOCTOR;

