-------------- BUCLES

------ VAMOS A MOSTRAR LA SUMA DE LOS PRIMEROS 100 NUMEROS

--- 1) LOOP .. END LOOP

declare
    --variables contador suelen denominarse con una sola letra: i, z, k
    i int;
    suma int;
begin
    --debemos inciar i, sino será null
    i := 1;
    --iniciamos suma
    suma := 0;
    loop 
        --instrucciones
        suma := suma + i;
        --incrementamos la variable i
        i := i + 1;
        --debemos indicar cuando queremos que el bucle finalice
        exit when i > 100;
    end loop;
    dbms_output.put_line('la suma de los 100 primeros numeros es '||suma); 
end;


---- 2) WHILE .. LOOP
--- LA CONDICION SE EVALUA ANTES DE ENTRAR

declare
    i int;
    suma int;
begin
    --debemos inciar la variables
    i := 1;
    suma := 0;
    while i <= 100 loop
        --instrucciones
        suma := suma + i;
        i := i + 1;
    end loop;
    dbms_output.put_line('la suma de los 100 primeros numeros es '||suma);
end;

tiene que ser <=100 porque si solo es menor como en 1) solo llegaría a 99.
sino tambien pude ser <101

declare
    i int;
    suma int;
begin
    --debemos inciar la variables
    i := 1;
    suma := 0;
    while i < 101 loop
        --instrucciones
        suma := suma + i;
        i := i + 1;
    end loop;
    dbms_output.put_line('la suma de los 100 primeros numeros es '||suma);
end;



---3) BUCLE FOR .. LOOP (CONTADOR)
-- CUANDO SABEMOS EL INCIO Y EL FINAL

declare
    suma int;
begin
    suma := 0;
    for i in 1..100 loop
        suma := suma + i;
    end loop;
    dbms_output.put_line('la suma de los 100 primeros numeros es '||suma);
end;


declare
    suma int;
begin
    suma := 0;
    for contador in 1..100 loop
        suma := suma + contador;
    end loop;
    dbms_output.put_line('la suma de los 100 primeros numeros es '||suma);
end;



----------- GOTO   Etiqueta; 

Salta del goto a tu etiqueta sin utilizar el loop o lo que haya entre medio.

declare
    suma int;
begin
    suma := 0;
    dbms_output.put_line ('Incio');
    goto codigo;
    dbms_output.put_line ('Antes del bucle');
    for contador in 1..100 loop
        suma := suma + contador;
    end loop;
    <<codigo>>
    dbms_output.put_line ('Después del bucle');
    dbms_output.put_line('la suma de los 100 primeros numeros es '||suma);
end;


?) ORDEN    NULL 



---- EJEMPLOS:

-- BUCLE PARA MOSTRAR NUMEROS ENTRE 1 Y 10
-- 1) BUCLE WHILE
-- 2) BUCLE FOR

1)

declare
    i int;
begin
    i := 1;
    while i <= 10 loop
        dbms_output.put_line(i);
        i := i + 1;
    end loop;
    dbms_output.put_line('Fin del bucle While');
end;

2)

declare

begin
    for i in 1..10 loop
        dbms_output.put_line (i);
    end loop;
    dbms_output.put_line('Fin del bucle For');
end;


--- PEDIR AL USUARIO UN NUMERO INICIO &incio Y UN NUMERO FINAL
--- MOSTRAR LO NUMEROS COMPRENDIDOS ENTRE DICHO RANGO.
set define on;
declare
    inicio int;
    fin int;
begin
    inicio := &inicial;
    fin := 12;
    for i in inicio..fin loop
        dbms_output.put_line (i);
    end loop;
    dbms_output.put_line('Fin del programa');
end;

undefine inicial;

undefine final;

--- PEDIR AL USUARIO UN NUMERO INICIO &incio Y UN NUMERO FINAL
--- MOSTRAR LO NUMEROS COMPRENDIDOS ENTRE DICHO RANGO.

set define on;

declare
    inicio int;
    fin int;
begin
    inicio := &inicial;
    fin := &final;
    for i in inicio..fin loop
        dbms_output.put_line (i);
    end loop;
    dbms_output.put_line('Fin del programa');
end;

undefine inicial;

undefine final;

set define on;
set define &;




--- SI EL NUMERO INCIAL ES MAYOR AL MENOR QUE LO DIGA EL PROGRAMA

declare
    inicio int;
    fin int;
begin
    inicio := &inicial;
    fin := &final;
    --preguntamos por los valores de los numeros que nos han dado
    if (inicio > fin) then
        dbms_output.put_line ('El número de incio (' || inicio || ') debe ser menor al número de fin (' || fin || ')');
    else
    for i in inicio..fin loop
        dbms_output.put_line (i);
        end loop;
    end if;
    dbms_output.put_line('Fin del programa');
end;

undefine inicial;

undefine final;


--- queremos un bucle pidiendo un inicio y un fin

-- mostrar los numeros pares comprendidos enre dicho incio y fin

declare
    ini int;
    fin int;
begin
    ini := &inicial;
    fin := &final;
    for i in ini..fin loop
        if (mod(i,2)=0) THEN
            DBMS_OUTPUT.PUT_LINE(i);
        end if;
    end loop;
    DBMS_OUTPUT.PUT_LINE('Fin de programa');
end;

undefine inicial;

undefine final;


-- CONJETURA DE COLLATZ
-- La teoría indica que cualquier número siempre llegará a ser 1 siguiendo una serie de instrucciones:
-- Si el número es par se divide entre 2
-- Si el número es impar, se multipla por 3 y sumamos 1
-- 6/2=3*3+1=10/2=5*3+1=16/2=8/2=4/2=2/2=1

declare
    numero int;
begin
    numero := &valor;
    while numero <> 1 loop
        --Averiguamos si es par o impar
        if (mod(numero,2)=0) then
            numero := numero / 2;
        else
            numero := numero * 3 + 1;
        end if;
        dbms_output.put_line (numero);
    end loop;
    dbms_output.put_line ('Fin de programa');
end;

undefine valor;

-- MOSTRAR LA TABLA DE MULTIPLICAR DE UN NÚMERO QUE PIDAMOS AL USUARIO

declare
    numero int;
    resultado int;
begin
    numero := &valor;
    for i in 1..10 loop
        resultado := numero * i;
        dbms_output.put_line (numero || '*' || i || '=' || resultado);
     end loop;
    dbms_output.put_line ('Fin de programa');
end;

undefine valor;

-- QUIERO UN PROGRAMA QUE NOS PEDIRÁ UN TEXTO
-- DEBEMOS RECORRER DICHO TEXTO LETRA A LETRA, ES DECIR, MOSTRAMOS CADA LETRA DEL TEXTO DE FORMA INDIVIDUAL.

declare
    v_texto varchar2 (50);
    v_longitud int;
    v_letra varchar2 (1);
begin
    v_texto := '&texto';
    -- UN ELEMENTO EN ORACLE EMPIEZA EN 1
    -- en un lugar de la mancha...
    v_longitud := length (v_texto);
    for i in 1..v_longitud loop
        v_letra := substr (v_texto, i, 1);
        DBMS_OUTPUT.PUT_LINE(v_letra);
    end loop;
    dbms_output.put_line ('Fin de programa');
end;

undefine texto;


-- Necesito un programa donde el usuario introducirá un texto númerico: 1234
-- Necesito mostrar la suma de todos los caracteres numéricos en un mensaje.
-- La suma de 1234 es 10.

declare
    v_texto_numero varchar2 (50);
    v_longitud int;
    v_letra char (1);
    v_numero int;
    v_suma int;
begin
    v_suma := 0;
    v_texto_numero := &texto;
    v_longitud := length (v_texto_numero);
    for i in 1..v_longitud loop
        v_letra := substr(v_texto_numero, i, 1);
        v_numero := to_number (v_letra);
        v_suma := v_suma + v_numero;

    end loop;
    dbms_output.put_line('La suma de ' || v_texto_numero || ' es ' || v_suma);
end;

undefine texto;



--- PEDIR AL USUARIO UN NUMERO INICIO &incio Y UN NUMERO FINAL
--- MOSTRAR LO NUMEROS COMPRENDIDOS ENTRE DICHO RANGO.

set define on;

declare
    inicio int;
    fin int;
begin
    inicio := &inicial;
    fin := &final;
    for i in inicio..fin loop
        dbms_output.put_line (i);
    end loop;
    dbms_output.put_line('Fin del programa');
end;

undefine inicial;

undefine final;

set define on;
set define &;




--- SI EL NUMERO INCIAL ES MAYOR AL MENOR QUE LO DIGA EL PROGRAMA

declare
    inicio int;
    fin int;
begin
    inicio := &inicial;
    fin := &final;
    --preguntamos por los valores de los numeros que nos han dado
    if (inicio > fin) then
        dbms_output.put_line ('El número de incio (' || inicio || ') debe ser menor al número de fin (' || fin || ')');
    else
    for i in inicio..fin loop
        dbms_output.put_line (i);
        end loop;
    end if;
    dbms_output.put_line('Fin del programa');
end;

undefine inicial;

undefine final;


--- queremos un bucle pidiendo un inicio y un fin

-- mostrar los numeros pares comprendidos enre dicho incio y fin

declare
    ini int;
    fin int;
begin
    ini := &inicial;
    fin := &final;
    for i in ini..fin loop
        if (mod(i,2)=0) THEN
            DBMS_OUTPUT.PUT_LINE(i);
        end if;
    end loop;
    DBMS_OUTPUT.PUT_LINE('Fin de programa');
end;

undefine inicial;

undefine final;


-- CONJETURA DE COLLATZ
-- La teoría indica que cualquier número siempre llegará a ser 1 siguiendo una serie de instrucciones:
-- Si el número es par se divide entre 2
-- Si el número es impar, se multipla por 3 y sumamos 1
-- 6/2=3*3+1=10/2=5*3+1=16/2=8/2=4/2=2/2=1

declare
    numero int;
begin
    numero := &valor;
    while numero <> 1 loop
        --Averiguamos si es par o impar
        if (mod(numero,2)=0) then
            numero := numero / 2;
        else
            numero := numero * 3 + 1;
        end if;
        dbms_output.put_line (numero);
    end loop;
    dbms_output.put_line ('Fin de programa');
end;

undefine valor;

-- MOSTRAR LA TABLA DE MULTIPLICAR DE UN NÚMERO QUE PIDAMOS AL USUARIO

declare
    numero int;
    resultado int;
begin
    numero := &valor;
    for i in 1..10 loop
        resultado := numero * i;
        dbms_output.put_line (numero || '*' || i || '=' || resultado);
     end loop;
    dbms_output.put_line ('Fin de programa');
end;

undefine valor;

-- QUIERO UN PROGRAMA QUE NOS PEDIRÁ UN TEXTO
-- DEBEMOS RECORRER DICHO TEXTO LETRA A LETRA, ES DECIR, MOSTRAMOS CADA LETRA DEL TEXTO DE FORMA INDIVIDUAL.

declare
    v_texto varchar2 (50);
    v_longitud int;
    v_letra varchar2 (1);
begin
    v_texto := '&texto';
    -- UN ELEMENTO EN ORACLE EMPIEZA EN 1
    -- en un lugar de la mancha...
    v_longitud := length (v_texto);
    for i in 1..v_longitud loop
        v_letra := substr (v_texto, i, 1);
        DBMS_OUTPUT.PUT_LINE(v_letra);
    end loop;
    dbms_output.put_line ('Fin de programa');
end;

undefine texto;


-- Necesito un programa donde el usuario introducirá un texto númerico: 1234
-- Necesito mostrar la suma de todos los caracteres numéricos en un mensaje.
-- La suma de 1234 es 10.

declare
    v_texto_numero varchar2 (50);
    v_longitud int;
    v_letra char (1);
    v_numero int;
    v_suma int;
begin
    v_suma := 0;
    v_texto_numero := &texto;
    v_longitud := length (v_texto_numero);
    for i in 1..v_longitud loop
        v_letra := substr(v_texto_numero, i, 1);
        v_numero := to_number (v_letra);
        v_suma := v_suma + v_numero;

    end loop;
    dbms_output.put_line('La suma de ' || v_texto_numero || ' es ' || v_suma);
end;

undefine texto;