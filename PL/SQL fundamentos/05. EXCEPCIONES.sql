--------- EXCEPCIONES

-- CAPTURAR UNA EXCEPCION DEL SISTEMA

/
declare
    v_num1 number := &numero1;
    v_num2 number := &numero2;
    v_division number;
begin
    v_division := v_num1 / v_num2;
    dbms_output.put_line ('La división es ' || v_division);
exception
    when ZERO_DIVIDE then
        dbms_output.put_line ('Error al dividir entre 0');
end;
/

undefine v_num1;
undefine v_num2;

-- CUANDO LOS EMPLEADOS TENGAN UNA COMISION CON VALOR 0;
-- LANZAREMOS UNA EXCEPCION
-- TENDREMOS UNA TABLA DONDE ALMACENAREMOS LOS EMPLEADOS CON COMISION MAYOR A CERO


create table emp_comision (apellido varchar2 (50), comision number (9));

declare
    cursor cursor_emp is
    select APELLIDO, COMISION from EMP order by COMISION DESC;
    exception_comision EXCEPTION;
begin
    for v_record in cursor_emp
    loop
        insert into emp_comision values (v_record.apellido, v_record.comision);
        if (v_record.COMISION = 0) then
            raise exception_comision;
        end if;
    end loop;
exception
    when exception_comision then
        dbms_output.put_line('Comisiones a ZERO');
    --quiero detener esto cuando la comisión sea 0
end;

select * from emp_comision;

--PRAGMA EXCEPTIONS

declare
    exception_nulos EXCEPTION;
    PRAGMA EXCEPTION_INIT (exception_nulos, -1400);
begin
    insert into DEPT values (null, 'DEPARTAMENTO', 'PRAGMA');
exception
    when exception_nulos then
        dbms_output.put_line ('No me sirve los nulos...');
end;


select * from DEPT;

declare
    v_id number;
begin
    select DEPT_NO into v_id
    from DEPT
    where DNOMBRE = 'VENTAS';
    dbms_output.put_line ('Ventas es el número ' || v_id);
exception
    when TOO_MANY_ROWS then
        dbms_output.put_line ('Demasiadas filas en cursor');
    when OTHERS then
        dbms_output.put_line ('Algo está pasando...');
end;


declare
    v_id number;
begin
    select DEPT_NO into v_id
    from DEPT
    where DNOMBRE = 'bENTAS';
    dbms_output.put_line ('Ventas es el número ' || v_id);
exception
    when TOO_MANY_ROWS then
        dbms_output.put_line ('Demasiadas filas en cursor');
    when OTHERS then
        dbms_output.put_line (to_char(SQLCODE) || ' ' || SQLERRM);
end;


declare
    v_id number;
begin
    RAISE_APPLICATION_ERROR(-20001, 'Puedo hacer esto con Exception??');
    select DEPT_NO into v_id
    from DEPT
    where DNOMBRE = 'bENTAS';
    dbms_output.put_line ('Ventas es el número ' || v_id);
end;



Declare 

  codigo dept.dept_no%type; 

begin 

   select dept_no into codigo 

   from dept  

   where dnombre = 'VENTAS'; 

   dbms_output.put_line ('El departamento de Ventas tiene  codigo: '||codigo); 

  exception 

   when TOO_MANY_ROWS then 

              dbms_output.put_line ('Coinciden en nombre varios departamentos'); 

   when OTHERS then 

      dbms_output.put_line (to_char(SQLCODE) || '     ' || SQLERRM); 

end; 