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

------- por problema de "SUSTITUCION CANCELADA" paso a doc Oracle XE Día 12 - 03. BUCLES bis
