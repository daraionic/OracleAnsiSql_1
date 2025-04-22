------ 04. CURSORES

-- bloque para consulas de acción
-- insertar un departamento en un bloque pl/sql dinámico

declare
    v_nombre dept.dnombre%type;
    v_loc dept.loc%type;
    -- el %type es para tomar el tipo de campo que esta esa columna (varchar, int o el que sea)
begin
    --vamos a realiza un bucle para insertar 5 departamentos
    for i in 1..5 loop
        v_nombre := 'Departamento' || i;
        v_loc := 'Localidad' || i;
        insert into DEPT values (i, v_nombre, v_loc);
    end loop;
    dbms_output.put_line('Fin de programa');
end;

select * from DEPT;

-- VAMOS A PROBAR HACIENDO UNA SUBCONSULTA:

declare
    v_nombre dept.dnombre%type;
    v_loc dept.loc%type;
    -- el %type es para tomar el tipo de campo que esta esa columna (varchar, int o el que sea)
begin
    --vamos a realiza un bucle para insertar 5 departamentos
    for i in 1..5 loop
        v_nombre := 'Departamento' || i;
        v_loc := 'Localidad' || i;
        insert into DEPT values 
        ((select max (DEPT_NO) + 1 from DEPT), v_nombre, v_loc);
    end loop;
    dbms_output.put_line('Fin de programa');
end;


-- Relizar un bloque PL/SQL que pedirá un número al user y mostrará el departamento con dicho número.

declare
    v_id int;
begin
    v_id := &numero;
    select * from DEPT where DEPT_NO = v_id;
end;

undefine numero;

-- En este caso va a dar fallo porque nunca podemos usar un select dentro de una consula PL/SQL. El caso anterior funcionó porque esta dentro de una subconsulta.

-- INSERT, UPDATE, DELETE: Son las únicas que funcionan que son las consultas de acción.

--

-- DOS TIPOS DE CURSORES:

-- IMPLICITOS solo devuelve una fila, si devuelve mas de una fila dará error.

-- EXPLICITOS tengo que declarar el cursor

--

-- CURSORES IMPLICITOS SOLAMENTE PUEDEN DEVOLVER UNA FILA

-- RECUEPERAR EL OFICIO DEL EMPLEADO REY

declare
    v_oficio EMP.OFICIO%TYPE;
begin
    select OFICIO from EMP where upper(APELLIDO)='REY';
end;

-- DARA ERROR PORQUE NO SE PUEDE PONER SELECT EN UNA CONSULTA PL

declare
    v_oficio EMP.OFICIO%TYPE;
begin
    select OFICIO into v_oficio from EMP where upper(APELLIDO)='REY';
    dbms_output.put_line ('El oficio de REY es...' || v_oficio);
end;

-- ESTE NO DA ERROR PORQUE NO ES UN SELECT, SINO QUE ES UN CURSOR. LO UNICO QUE DIFERENCIA UN SELECT NORMAL A UN SELECT CURSOR ES EL INTO QUE TIENE AL LADO.LOGMNR$COL_GG_TABF_PUBLIC


-- CURSOR EXPLICITO
-- PUEDEN DEVOLVER MAS DE UNA FILA Y ES NECESARIO DECLARARLOS

-- MOSTRAR EL APELLIDO Y SALARIO DE TODOS LOS EMPLEADOS

declare
    v_ape EMP.APELLIDO%TYPE;
    v_sal EMP.SALARIO%TYPE;
    --declaramos nuestro cursor con una consulta
    --la consula debe tener los mismos datos para luego
    --hacer el fetch
    cursor CURSOREMP IS
    select APELLIDO, SALARIO from EMP;
begin
    --1) abrir el cursor
    open CURSOREMP;
    --bucle infinito
    loop
        ---2) extraemos los datos del cursor
        fetch CURSOREMP into v_ape, v_sal;
        --dibujamos los datos
        dbms_output.put_line('Apellido: ' || v_ape || ', Salario: ' || v_sal);
        exit when CURSOREMP%notfound;
    end loop;
    --3) cerramos cursor
    close CURSOREMP;
end;


declare
    v_ape EMP.APELLIDO%TYPE;
    v_sal EMP.SALARIO%TYPE;
    cursor CURSOREMP IS
    select APELLIDO, SALARIO from EMP;
begin
    open CURSOREMP;
    loop
        fetch CURSOREMP into v_ape, v_sal;
        dbms_output.put_line('Apellido: ' || v_ape || ', Salario: ' || v_sal);
        exit when CURSOREMP%notfound;
    end loop;
    close CURSOREMP;
end;

select * from EMP where apellido = 'PEREZ';

-- SI LO DEJAMOS ASÍ MARCARÁ DE VUELTA LA ULTIMA LINEA PORQUE LEE, PINTA, VUELVE, PINTA Y TERMINA


declare
    v_ape EMP.APELLIDO%TYPE;
    v_sal EMP.SALARIO%TYPE;
    --declaramos nuestro cursor con una consulta
    --la consula debe tener los mismos datos para luego
    --hacer el fetch
    cursor CURSOREMP IS
    select APELLIDO, SALARIO from EMP;
begin
    --1) abrir el cursor
    open CURSOREMP;
    --bucle infinito
    loop
        ---2) extraemos los datos del cursor
        fetch CURSOREMP into v_ape, v_sal;
        --3) preguntamos si hemos terminado
        exit when CURSOREMP%notfound;
        -- dibujamos los datos
        dbms_output.put_line('Apellido: ' || v_ape || ', Salario: ' || v_sal);
    end loop;
    --4) cerramos cursor
    close CURSOREMP;
end;

declare
    v_ape EMP.APELLIDO%TYPE;
    v_sal EMP.SALARIO%TYPE;
    cursor CURSOREMP IS
    select APELLIDO, SALARIO from EMP;
begin
    open CURSOREMP;
    loop
        fetch CURSOREMP into v_ape, v_sal;
        exit when CURSOREMP%notfound;
        dbms_output.put_line('Apellido: ' || v_ape || ', Salario: ' || v_sal);
    end loop;
    close CURSOREMP;
end;

-- aca estaria bien porque cierra, pinta y termina.


------------

-- ATRIBUTO ROWCOUNT PARA LAS CONSULTAS DE ACCIÓN

-- INCREMENTAR EN 1 EL SALARIO DE LOS EMPLEADOS DEL DEPARTAMENTO 10.

-- MOSTRAR EL NUMERO DE EMPLEADOS MODIFICADOS

    -- no lo necesitamos el declare.....
begin
    update EMP set salario = salario + 1
    where DEPT_NO=10;
    dbms_output.put_line('Empeados modificados '|| SQL%ROWCOUNT);
end;

select * from EMP where DEPT_NO = 10;

select * from EMP order by SALARIO DESC;


-- INCREMENTAR EN 10.000 AL EMPLEADO QUE MENOS COBRE EN LA EMPRESA

-- 1) ¿Que necesito para esto?
-- necesitamos el minimo salario: devolvería una fila
-- 2) ¿qué más?
-- también necesitamos update a ese salario

declare
    v_salario EMP.SALARIO%TYPE;
begin
    update EMP set SALARIO = SALARIO + 10000 where SALARIO = (select min(SALARIO) from EMP);
    dbms_output.put_line('El salario minimo'|| v_salario);
end;

--- ESTA BIEN ASI PERO PUEDE ESTAR MEJOR CON UNA VARIABLE EN VEZ DE UNA SUBCONSULTA EN LO DEL SALARIO MINIMO/ULTIMA PARTE

declare
    v_minimo_salario EMP.SALARIO%TYPE;
begin
    -- realizamos una consulta para recuperar el minimo salario
    select min(SALARIO) into v_minimo_salario from EMP;
    update EMP set SALARIO = SALARIO + 10000 
    where SALARIO = v_minimo_salario;
    dbms_output.put_line('Salario incrementado a '|| SQL%ROWCOUNT || ' empleados');
end;

declare
    v_minimo_salario EMP.SALARIO%TYPE;
begin
    select min(SALARIO) into v_minimo_salario from EMP;
    update EMP set SALARIO = SALARIO + 10000 
    where SALARIO = v_minimo_salario;
    dbms_output.put_line('Salario incrementado a '|| SQL%ROWCOUNT || ' empleados');
end;

--- ESTAMOS HACIENDO OTRO SELECT PARA GUARDAR OTRO DATO:

declare
    v_minimo_salario EMP.SALARIO%TYPE;
    v_apellido EMP.APELLIDO%TYPE;
begin
    --realizamos una consulta para recuperar el minimo salario
    select min(SALARIO) into v_minimo_salario from EMP;
    -- almacemanos la pesona que cobra dicho salario
    select APELLIDO into v_apellido from EMP 
    where SALARIO = v_minimo_salario;
    update EMP set SALARIO = SALARIO + 10000 
    where SALARIO = v_minimo_salario;
    dbms_output.put_line('Salario incrementado a '|| SQL%ROWCOUNT || ' empleados. Sr/Sra ' || v_apellido);
end;


---Realizar un codigo PL/SQL donde pediremos el numero, nombre y localidad de un departamento
-- Si el depto existe, modificamos su nombre y localidad.
-- Si el depto no existe, lo insertamos.

-- 10, I+D, GIJON

-- 1) ¿Que necesito para esto?
-- el numero de un depto
-- 2) ¿que mas?
-- saber si existe o no
-- 3) ¿que mas?
-- si existe, update
-- si no existe, insert


declare
    v_id DEPT.DEPT_NO%TYPE;
    v_nombre DEPT.DNOMBRE%TYPE;
    v_localidad DEPT.LOC%TYPE;
    v_existe DEPT.DEPT_NO%TYPE;
    cursor DEPARTAMENTODEPT IS
    select DEPT_NO from DEPT where DEPT_NO = v_id;
begin
    v_id := &iddepartamento;
    v_nombre := '&nombre';
    v_localidad := '&localidad';
    open DEPARTAMENTODEPT;
    fetch DEPARTAMENTODEPT into v_existe;
    if (DEPARTAMENTODEPT%found) then
        dbms_output.put_line ('Update');
        update DEPT set DNOMBRE = v_nombre, LOC = v_localidad where DEPT_NO = v_id;
    else
        dbms_output.put_line ('Insert');
        insert into DEPT values (v_id, v_nombre, v_localidad);
    end if;
    close DEPARTAMENTODEPT;
end;

undefine iddepartamento;
undefine nombre;
undefine localidad;

select * from DEPT;

declare
    v_id DEPT.DEPT_NO%TYPE;
    v_nombre DEPT.DNOMBRE%TYPE;
    v_localidad DEPT.LOC%TYPE;
    v_existe DEPT.DEPT_NO%TYPE;
begin
    v_id := &iddepartamento;
    v_nombre := '&nombre';
    v_localidad := '&localidad';
    select COUNT(DEPT_NO) into v_existe from DEPT
    where DEPT_NO = v_id;
    if (v_existe = 0) then
        dbms_output.put_line ('Insert');
        insert into DEPT values (v_id, v_nombre, v_localidad);
    else
        dbms_output.put_line ('Update');
        update DEPT set DNOMBRE = v_nombre, LOC = v_localidad where DEPT_NO = v_id;
    end if;
end;


-- REALIZAR UN CÓDIGO PL/SQL PARA MODIFICAR EL SALARIO DE UN EMPLEADO ARROYO
-- SI EL EMPLEADO COBRA MÁS DE 250.000, LE BAJAMOS EL SUELDO A 10.000
-- SINO LE SUBIMOS EL SUELDO A 10.000

declare

begin

end;


