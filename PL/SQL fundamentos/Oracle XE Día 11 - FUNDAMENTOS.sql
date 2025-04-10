-- bloque para insertar un departamento

DECLARE
    v_numero dept.dept_no%type;
    v_nombre dept.dnombre%type;
    v_localidad dept.loc%type;
BEGIN
    v_numero := &numero;
    v_nombre := '&nombre';
    v_localidad := '&localidad';
    insert into DEPT values (v_numero, v_nombre, v_localidad);
end;

undefine numero;
undefine nombre;
undefine localidad;

select * from dept;



2. Insertar en la tabla EMP un empleado con código 9999 asignado directamente en la variable con 
%TYPE, apellido ‘PEREZ’, oficio ‘ANALISTA’ y código del departamento al que pertenece 10.

select * from EMP;
describe EMP;

declare
    v_codigo emp.emp_no%type;
    v_apellido emp.apellido%type;
    v_oficio emp.oficio%type;
    v_numero_dept emp.dept_no%type;
begin
    v_codigo := &codigo;
    v_apellido := '&apellido';
    v_oficio := '&oficio';
    v_numero_dept := &dept_no;
    insert into EMP (emp_no, apellido, oficio, dept_no) values (v_codigo, v_apellido, v_oficio, v_numero_dept);
end;

insert into DEPT values (88 ,'aaa', 'aa');
insert into DEPT (dept_no, loc) values (88 , 'aa');

undefine codigo;
undefine apellido;
undefine oficio;
undefine dept_no;


3. Incrementar el salario en la tabla EMP en 200 EUROS a todos los trabajadores 
que sean ‘ANALISTA’, mediante un bloque anónimo PL, asignando dicho valor a una variable declarada con %TYPE.

declare
    v_oficio emp.oficio%type;
begin
    v_oficio := '&oficio';
    update EMP set SALARIO = SALARIO + 200 where UPPER (OFICIO) = UPPER(v_oficio);
end;

select * from EMP;

rollback;

4. Realizar un programa que devuelva el número de cifras de un número entero, 
introducido por teclado, mediante una variable de sustitución.

declare
    numero1 int;
    longitud int;
begin
    numero1 := '&num1';
    longitud := LENGTH(numero1);
    dbms_output.put_line ('El número de cifras del número introducido es ' || longitud);
end;


6. Crear un bloque PL que actualice el salario de los empleados que no cobran comisión en un 5%.

select * from EMP;

declare
    v_salario emp.salario%type;
begin
    v_salario :=
end;
