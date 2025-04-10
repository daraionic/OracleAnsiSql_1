---- ESTRUCTURAS

-- DBEMOS COMPROBAR SI UN NUMERO ES POSITIVO O NEGATIVO

declare
    v_numero int;
begin
    -- pedimos el numero al user
    v_numero := &numero;
    -- preguntamos por el propio numero
    if (v_numero >= 0) then
        dbms_output.put_line('Positivo: ' || v_numero);
    end if;
    dbms_output.put_line('Fin de programa');
end;

undefine numero;


declare
    v_numero int;
begin
    -- pedimos el numero al user
    v_numero := &numero;
    -- preguntamos por el propio numero
    if (v_numero >= 0) then
        dbms_output.put_line('Positivo: ' || v_numero);
    else
        dbms_output.put_line('Negativo: ' || v_numero);
    end if;
    dbms_output.put_line('Fin de programa');
end;


-- DEBEMOS COMPROBAR SI UN NUMERO ES POSITIVO, NEGATIVO O CERO

declare
    v_numero int;
begin
    v_numero := &numero;
    if (v_numero > 0) then
        dbms_output.put_line('Positivo: ' || v_numero);
    elsif (v_numero = 0) then
        dbms_output.put_line('Cero: ' || v_numero);
    else
        dbms_output.put_line('Negativo: ' || v_numero);
    end if;
    dbms_output.put_line('Fin de programa');
end;

undefine numero;





------- PEDIR UN NUMERO AL USARIO DEL 1 AL 4
1.- Primavera
2.- Verano
3.- Otoño
4.- Invierno
Si nos da otro número, le indicamos que está mal


declare
    v_numero int;
begin
    v_numero := &numero;
    if (v_numero=1) then
        dbms_output.put_line('Primavera');
    elsif (v_numero=2) then
        dbms_output.put_line('Verano');
    elsif (v_numero=3) then
        dbms_output.put_line('Otoño');
    elsif (v_numero=4) then
        dbms_output.put_line('Invierno');
    else
        dbms_output.put_line('Valor Incorrecto: ' || v_numero);
    end if;
        dbms_output.put_line('Fin de programa');
end;





