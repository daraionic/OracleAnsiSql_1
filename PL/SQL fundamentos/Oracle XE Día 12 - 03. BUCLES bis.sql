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


--- SI EL NUMERO INCIAL ES 
declare
    inicio int;
    fin int;
begin
    inicio := &inicial;
    fin := &final;
    --preguntamos por los valores de los numeros que nos han dado
    if (inicio > fin) then
        dbms_output.put_line ('El número de incio' (' || incio || ') debe ser menor al número de fin (' || fin || ')');
    else
    for i in inicio..fin loop
        dbms_output.put_line (i);
        end loop;
    end if;
    dbms_output.put_line('Fin del programa');
end;
