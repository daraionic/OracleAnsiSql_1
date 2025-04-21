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