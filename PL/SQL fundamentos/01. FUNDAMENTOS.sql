------ FUNDAMENTOS PL-SQL

Es un lenguaje de programación

Estructura de código para que realice acciones dependiendo de variables


declare
    -- MI COMENTARIO
    -- DECLARAMOS UNA VARIABLE
    numero int;
begin
    dbms_output.put_line('Mi primer bloque anónimo');
end;


declare
    -- MI COMENTARIO
    -- DECLARAMOS UNA VARIABLE
    numero int;
begin
    dbms_output.put_line('Mi primer bloque anónimo 2');
end;


declare
    -- MI COMENTARIO
    -- DECLARAMOS UNA VARIABLE
    numero int;
begin
    dbms_output.put_line('Mi primer bloque anónimo ');
    dbms_output.put_line('Valor número: ' || numero);
end;


declare
    -- MI COMENTARIO
    -- DECLARAMOS UNA VARIABLE
    numero int;
begin
    dbms_output.put_line('Mi primer bloque anónimo ');
    numero :=44;
    dbms_output.put_line('Valor número: ' || numero);
end;


declare
    -- MI COMENTARIO
    -- DECLARAMOS UNA VARIABLE
    numero int;
begin
    dbms_output.put_line('Mi primer bloque anónimo ');
    numero :=44;
    dbms_output.put_line('Valor número: ' || numero);
    numero :=22;
    dbms_output.put_line('Valor número: ' || numero);
end;


declare
    -- MI COMENTARIO
    -- DECLARAMOS UNA VARIABLE
    numero int;
    texto varchar2(50);
begin
    texto := 'mi primer PL/SQL';
    dbms_output.put_line('Mensaje: ' || texto);
    dbms_output.put_line('Mi primer bloque anónimo ');
    numero :=44;
    dbms_output.put_line('Valor número: ' || numero);
    numero :=22;
    dbms_output.put_line('Valor número: ' || numero);
end;








declare
    nombre varchar2(30);
begin
    nombre := 'Alumno';
    dbms_output.put_line('Su nombre es '|| nombre);
end;


declare
    nombre varchar2(30);
begin
    nombre := '&dato';
    dbms_output.put_line('Su nombre es '|| nombre);
end;





declare
    fecha date;
    texto varchar2(50);
    longitud int;
begin
    fecha := SYSDATE;
    texto := '&data';
    -- QUIERO ALMACENAR LA LONGITUD DEL TEXTO
    longitud := LENGTH(texto);
    -- QUIERO PINTAR 3 MENSAJES:
    -- LA LONGITUD DE SU TEXTO ES 41
    dbms_output.put_line('La longitud del texto es ' || longitud);
    -- HOY ES ...Miércoles
    dbms_output.put_line('Hoy es '|| to_char(fecha,'day'));
    dbms_output.put_line(texto);
end;




Ejemplo PL-SQL para sumar dos números con un programa 

--REALIZAR UN PROGRAMA DONDE PEDIREMOS DOS NUMEROS AL USUARIO. 

--MOSTRAREMOS POR PANTALLA LA SUMA. 

--qué información tengo que guardar? 

--numero1  numero2  suma 


declare
    numero1 int;
    numero2 int;
    suma int;
begin
    numero1 := '&num1';
    numero2 := '&num2';
    suma := numero1 + numero2;
    dbms_output.put_line ('La suma de ' || numero1 || ' + ' || numero2 || ' = ' || suma);
end;

-- QUITAR LA DEFINICIÓN DE LAS VARIABLES
undefine num1; 
undefine num2;


Ejemplo: 

Debemos crear un bloque pl-sql dónde incrementaremos el salario de los empleados de un departamento que nos indiquen con una variable. 


declare 
    -- DECLARAMOS UNA VARIABLE PARA ALMACENAR EL NUMERO DE DEPARTAMENTO
    v_departamento int;
begin 
    --pedimos un número de departamento al usuario 
    v_departamento := &dept; 
    update emp set salario = salario + 3 where dept_no = v_departamento; 
end;

undefine dept;

select * from EMP;



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
    v_comision int;
begin
    v_comision := &comision;
    update EMP set SALARIO = SALARIO * 0.05 where comision = v_comision);
end; MAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAL

SOLUCION:

DECLARE 
    V_INCREMENTO NUMBER := 0.05; 
BEGIN 
    UPDATE EMP SET SALARIO = SALARIO + (SALARIO * V_INCREMENTO) WHERE COMISION IS NULL; 
END; 
