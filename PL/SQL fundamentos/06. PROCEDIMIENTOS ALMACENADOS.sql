---EJEMPLO DE PROCEDIMIENTOS ALMACENADOS

-- STORED PROCEDURE

create or replace procedure sp_mensaje
as
begin
    --MOSTRAMOS UN MENSAJE
    dbms_output.put_line ('Hoy es juerbes con música......');
end;

-- LLAMADA AL PROCEDIMIENTO

begin
    sp_mensaje;
end;

-- PROCEDIMEITNO CON BLOQUE PL/SQL

declare
    v_numero number;
begin
    v_numero := 14;
    if v_numero > 0 then
        dbms_output.put_line('Positivo');
    else
        dbms_output.put_line('Negativo');
    end if;
end;

-- CREAMOS EL PROCEDIMIENTO

create or replace procedure sp_ejemplo_plsql
as
begin
    -- PROCEDIMIENTO CON BLOQUE PL/SQL
    declare
        v_numero number;
    begin
        v_numero := 14;
        if v_numero > 0 then
            dbms_output.put_line('Positivo');
        else
            dbms_output.put_line('Negativo');
        end if;
    end;
end;

--LAMADA
begin
    sp_ejemplo_plsql;
end;


-- TENEMOS OTRA SINTAXIS PARA TENER VARIABLES DE UN PROCEDIMIENTO.LOGMNR$COL_GG_TABF_PUBLIC
-- NO SE UTILIZA LA PALABRA declare

create or replace procedure sp_ejemplo_plsql12
as
    v_numero number := 14;
begin
     if v_numero > 0 then
            dbms_output.put_line('Positivo');
    else
        dbms_output.put_line('Negativo');
    end if;
end;

begin
    sp_ejemplo_plsql12;
end;

-- PROCEDIMIENTO PARA SUMAR DOS NUMEROS

create or replace procedure sp_sumar_numeros
(p_numero1 number, p_numero2 number)
as
    v_suma number;
begin
    v_suma := p_numero1 + p_numero2;
    dbms_output.put_line ('La suma de ' || p_numero1 || ' + ' || p_numero2 || ' es: ' || v_suma);
end;

-- LLAMADA AL PROCEDIMIENTO
begin
    sp_sumar_numeros (5, 6);
end;

-- NECESITO UN PROCEDIMIENTO PARA DIVIDIR DOS NUMEROS
-- SE LLAMARA sp_dividir_numeros

create or replace procedure sp_dividir_numeros
(p_numero1 number, p_numero2 number)
as
    v_division number;
begin
    v_division := p_numero1 / p_numero2;
    dbms_output.put_line ('La división entre ' || p_numero1 || ' y ' || p_numero2 || ' es ' || v_division);
end;

begin
    sp_dividir_numeros (10, 0);
end;

-- VAMOS A CREAR UNA EXCEPCION DENTRO

-- NECESITO UN PROCEDIMIENTO PARA DIVIDIR DOS NUMEROS
-- SE LLAMARA sp_dividir_numeros

create or replace procedure sp_dividir_numeros
(p_numero1 number, p_numero2 number)
as
    v_division number;
begin
    v_division := p_numero1 / p_numero2;
    dbms_output.put_line ('La división entre ' || p_numero1 || ' y ' || p_numero2 || ' es ' || v_division);
exception
    when ZERO_DIVIDE then
        dbms_output.put_line ('División entre cero PROCEDURE');
end;

begin
    sp_dividir_numeros (10, 0);
end;





-- REALIZAR UN PROCEDIMIENO PARA INSERTAR UN NUEVO DEPARTAMENTO

create or replace procedure sp_insertardepartamento
(p_id number, p_nombre varchar2(50), p_localidad varchar2(50))
as
begin
    insert into DEPT values (p_id, p_nombre, p_localidad);
end;

-- lo crea pero como hay errores, los guarda con errores. es porque no podemos poner la longuitud a los varchar o demas TYPE
--con longuitud por lo que es mejor sar el %TYPE

create or replace procedure sp_insertardepartamento
(p_id DEPT.DEPT_NO%TYPE, p_nombre DEPT.DNOMBRE%TYPE, p_localidad DEPT.LOC%TYPE)
as
begin
    insert into DEPT values (p_id, p_nombre, p_localidad);
end;

-- LLAMADA AL PROCEDIMIENTO

begin
    sp_insertardepartamento(11, '11', '11');
    -- NORMALMENE, DENTRO DE LOS PROCEDIMIENTOS DE ACCION SE INCLUYE COMMIT O ROLLBACK SI DIERA UNA EXCEPCION
    commit;
end;

select * from DEPT;

rollback;

-- VERSION 2:
-- REALIZAREMOS UN PROCEDIMINTO PARA INSERTAR UN NUEVO DEPARTAMENTO
-- GENERAMOS EL ID CON EL MAX AUTOMATICO DENTRO DEL PROCEDURE

create or replace procedure sp_insertardepartamento
(p_nombre DEPT.DNOMBRE%TYPE, p_localidad DEPT.LOC%TYPE)
as
    v_max_id DEPT.DEPT_NO%TYPE;
begin
    --REALIZAMOS EL CURSOR IMPLICITO PARA BUSCAR EL MAX ID
    select max (DEPT_NO) + 1 into v_max_id from DEPT;
    insert into DEPT values (v_max_id, p_nombre, p_localidad);
    -- NORMALMENE, DENTRO DE LOS PROCEDIMIENTOS DE ACCION SE INCLUYE COMMIT O ROLLBACK SI DIERA UNA EXCEPCION
    commit;
end;

-- llamada al procedimiento

begin
    sp_insertardepartamento ('miercoles', 'miercoles');
    -- NORMALMENE, DENTRO DE LOS PROCEDIMIENTOS DE ACCION SE INCLUYE COMMIT O ROLLBACK SI DIERA UNA EXCEPCION
    commit;
end;


-- REALIZAR UN PROCEDIMIENTO PARA INCREMENTAR EL SALARIO DE LOS EMPLEADOS POR UN OFICIO.
-- DEBEMOS ENVIAR EL OFICIO Y EL INCREMENTO.

select * from emp;

create or replace procedure sp_aumentoporoficio
(p_oficio EMP.OFICIO%TYPE, p_incremento number)
as
begin
    update EMP set SALARIO = (EMP.SALARIO + p_incremento) where upper (OFICIO) = upper (p_oficio);
end;


begin
    sp_aumentoporoficio ('PRESIDENTE', 4);
end;


-- NECESITO UN PROCEDIMIENTO PARA INSERTAR UN DOCTOR.
-- ENVIAMOS TODOS LOS DATOS DEL DOCTOR, EXCEPTO EL ID
-- DBEMOS RECUPERAR EL MAXIMO ID DE DOCTOR DENTRO DEL PROCEDIMIENTO

select * from DOCTOR;

create or replace procedure sp_nuevo_doctor
(p_hospital_cod DOCTOR.HOSPITAL_COD%TYPE, p_apellido DOCTOR.APELLIDO%TYPE, p_especialidad DOCTOR.ESPECIALIDAD%TYPE, p_salario DOCTOR.SALARIO%TYPE)
as
    v_max_id DOCTOR.DOCTOR_NO%TYPE;
begin
    select max (DOCTOR_NO) + 1 into v_max_id from DOCTOR;
    insert into DOCTOR values (p_hospital_cod, v_max_id, p_apellido, p_especialidad, p_salario);
    dbms_output.put_line ('Insertados ' || SQL%ROWCOUNT);
    commit;
end;

begin
    sp_nuevo_doctor (19, 'Dario N.', 'Oncologo', 35000);
end;


-- VERSION 2:
-- NECESITO UN PROCEDIMIENTO PARA INSERTAR UN DOCTOR.
-- ENVIAMOS TODOS LOS DATOS DEL DOCTOR, EXCEPTO EL D
-- DEBEMOS RECUPRAR EL MAX ID DE DOCTOR DENTRO DEL PROCEDIMIENTO
-- ENVIAMOS EL NOMBRE DEL HOSPITAL EN LUGAR DEL ID DEL HOSPITAL
-- CONTROLAR SI NO EXISTE EL HOSPITAL ENVIADO

select * from HOSPITAL;

select * from DOCTOR;

create or replace procedure sp_nuevo_doctor_2
(p_hospital_name HOSPITAL.NOMBRE%TYPE, p_apellido DOCTOR.APELLIDO%TYPE, p_especialidad DOCTOR.ESPECIALIDAD%TYPE, p_salario DOCTOR.SALARIO%TYPE)
as
    v_max_id DOCTOR.DOCTOR_NO%TYPE;
    v_hospital_cod DOCTOR.HOSPITAL_COD%TYPE;
begin
    select max (DOCTOR_NO) + 1 into v_max_id from DOCTOR;
    select HOSPITAL_COD into v_hospital_cod from HOSPITAL where lower (NOMBRE) = lower (p_hospital_name);
    insert into DOCTOR values (v_hospital_cod, v_max_id, p_apellido, p_especialidad, p_salario);
    dbms_output.put_line ('Insertados ' || SQL%ROWCOUNT);
    commit;
exception
    when no_data_found then
        dbms_output.put_line ('No existe el hospital ' || p_hospital_name);
end;


begin
    sp_nuevo_doctor_2 ('marañon', 'Paco N.', 'Oncologo', 35000);
end;



-- PODEMOS UTILIZAR CURSORES EXPLICITOS DENTRO DE LOS PROCEDIMIENTOS

-- REALIZAR UN PROCEDIMIENTOS PARA MOSTRAR LOS EMPLEADOS DE UN DETERMINADO NÚMERO DE DEPTO.

select * from EMP;

create or replace procedure sp_empleados_dept
(p_deptno EMP.DEPT_NO%TYPE)
as
    cursor cursor_emp is
    select * from EMP
    where DEPT_NO = p_deptno;
begin
    for v_reg_emp in cursor_emp
    loop
        dbms_output.put_line ('Apellido: ' || v_reg_emp.APELLIDO || ', Oficio: ' || v_reg_emp.OFICIO);
    end loop;
end;

begin
    sp_empleados_dept(30);
end;

-- LOS CURSORES EXPLICITOS (QUE DEVUELVEN MAS DE UN VALOR) NO APARECERÁ ERROR YA QUE SI NO ENCUENTRA ESTARÁ VACIO. LOS UNICOS CURSORES QUE APARECEN LOS ERRORES 
--SON LOS IMPLICITOS QUE SOLO TIENE QUE DEVOLVER UN VALOR Y APARECERÍA 'TOO MANY ROWS'

---------- parametros de salida

-- VAMOS A RELAIZAR UN PROCEDIMIENTO PARA ENVIAR EL NOMBRE DEL DEPTO Y DEVOLVER EL NUMERO DE DICHO DEPTO.

create or replace procedure sp_numerodepartamento
(p_nombre DEPT.DNOMBRE%TYPE, p_iddept out DEPT.DEPT_NO%TYPE)
as
    v_iddept DEPT.DEPT_NO%TYPE;
begin
    select DEPT_NO into v_iddept from DEPT
    where upper(DNOMBRE) = upper(p_nombre);
    p_iddept := v_iddept;
    dbms_output.put_line('El número de departamento es ' || v_iddept);
end;

create or replace procedure sp_numerodepartamento
(p_nombre DEPT.DNOMBRE%TYPE, p_iddept out DEPT.DEPT_NO%TYPE)
as
    v_iddept DEPT.DEPT_NO%TYPE;
begin
    select DEPT_NO into v_iddept from DEPT
    where upper(DNOMBRE) = upper(p_nombre);
    p_iddept := v_iddept;
    dbms_output.put_line('El número de departamento es ' || v_iddept);
end;

begin
    sp_numerodepartamento ('ventas');
end;

DECLARE
    v_iddept DEPT.DEPT_NO%TYPE;    -- Variable para almacenar el número de departamento
BEGIN
    -- Llamar al procedimiento pasando el nombre del departamento y la variable de salida
    sp_numerodepartamento('VENTAS', v_iddept);

END;

select * from DEPT;

-- NECESITO UN PROCEDIMIENTO PARA INCREMENTAR EN 1 EL SALARIO DE LOS EMPLEADOS DE UN DEPTO.
-- ENVIAREMOS AL PROCEDIMIENTO EL NOMBRE DEL DEPARTAMENTO.

create or replace procedure sp_incrementar_sal_dept
(p_nombre DEPT.DNOMBRE%TYPE)
as
    v_num DEPT.DEPT_NO%TYPE;
begin
    -- recuperareos el id del departamento a partir del nombre
    -- llamamos al procedimiento de numero para recuperar el numero a partir del nombre
    -- sp_numerodepartamento
    -- (p_nombre DEPT.DNOMBRE%TYPE, p_iddept out DEPT.DEPT_NO%TYPE)
    sp_numerodepartamento (p_nombre, v_num);
    update EMP set SALARIO = SALARIO + 1
    where DEPT_NO = v_num;
    dbms_output.put_line ('Salarios modificados: ' || SQL%ROWCOUNT);
end;

begin
    sp_incrementar_sal_dept('ventas');
end;



