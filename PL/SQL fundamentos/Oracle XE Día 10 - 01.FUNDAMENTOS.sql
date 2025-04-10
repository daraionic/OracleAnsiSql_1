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