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







Pediremos dos numeros al usuario y debemos devolver que número es mayor

declare
    v_numero1 int;
    v_numero2 int;
begin
    v_numero1 := &numero1;
    v_numero2 := &numero2;
    if (v_numero1 > v_numero2) then
        dbms_output.put_line('Número 1 es mayor a Número 2');
    elsif (v_numero1 < v_numero2) then
        dbms_output.put_line('Número 2 es mayor a Número 1');
    elsif (v_numero1 = v_numero2) then
        dbms_output.put_line('Ambos números son iguales');
    end if;
        dbms_output.put_line('Fin de programa');
end;

undefine numero1;
undefine numero2;





-- PEDIR UN NUMERO AL USUARIO E INDICAR SI ES PAR O IMPAR
select mod(8,2) as resto from dual;

declare
    v_numero int;
begin
    v_numero :=&numero;
    if (mod(v_numero,2) = 0) then
        dbms_output.put_line('El número es par ');
    else
        dbms_output.put_line('El número es impar ');
    end if;
        dbms_output.put_line ('Fin de programa');
end;

undefine numero;





--- Por supuesto, podemos perfectamente utilizar cualquier operador, tanto de comparación, como relacional en nuestros códigos.

--- Pedir una letra al usuario. Si la letra es vocal (a,e,i,o,u) pintamos vocal, sino consonante.

/
declare
    v_letra varchar2(1);
begin
    v_letra := LOWER('&letra');
    --- puede ser una a o una A por lo que vamos a ponerla en minus con LOWER
    if (v_letra = 'a' or v_letra = 'e' or v_letra = 'i' or v_letra = 'o' or v_letra = 'u') then
        DBMS_OUTPUT.PUT_LINE('Vocal ' || v_letra);
    else
        dbms_output.put_line('Consonante ' || v_letra);
    end if;
        dbms_output.put_line('Fin de programa');
end;
/


-- pedir tres numeros al usuario
-- debemos mostrar el mayor de ellos y el menor de ellos

/
declare
    v_num1 int;
    v_num2 int;
    v_num3 int;
    v_mayor int;
    v_menor int;
    v_intermedio int;
begin
    v_num1 := &num1;
    v_num2 := &num2;
    v_num3 := &num3;
    if (v_num1 >= v_num2 and v_num1 >= v_num3)then
        v_mayor := v_num1;
    elsif (v_num2 >= v_num1 and v_num2 >= v_num3)then
        v_mayor := v_num2;
    else
        v_mayor := v_num3;
    end if;
    if (v_num1 <= v_num2 and v_num1 <= v_num3) then
        v_menor := v_num1;
    elsif (v_num2 <= v_num1 and v_num2 <= v_num3)then
        v_menor := v_num2;
    else
        v_menor := v_num3;
    end if;
    dbms_output.put_line('Mayor: ' || v_mayor);
    dbms_output.put_line('Menor: ' || v_menor);
end;
/


-- igual que el anterior pero vamos agregar el intermedio

/
declare
    v_num1 int;
    v_num2 int;
    v_num3 int;
    v_mayor int;
    v_menor int;
    v_intermedio int;
    v_suma int;
begin
    v_num1 := &num1;
    v_num2 := &num2;
    v_num3 := &num3;
    if (v_num1 >= v_num2 and v_num1 >= v_num3)then
        v_mayor := v_num1;
    elsif (v_num2 >= v_num1 and v_num2 >= v_num3)then
        v_mayor := v_num2;
    else
        v_mayor := v_num3;
    end if;
    if (v_num1 <= v_num2 and v_num1 <= v_num3) then
        v_menor := v_num1;
    elsif (v_num2 <= v_num1 and v_num2 <= v_num3)then
        v_menor := v_num2;
    else
        v_menor := v_num3;
    end if;
    v_suma := v_num1 + v_num2 + v_num3;
    v_intermedio := v_suma - v_mayor - v_menor;
    dbms_output.put_line('Mayor: ' || v_mayor);
    dbms_output.put_line('Menor: ' || v_menor);
    dbms_output.put_line('Intermedio: ' || v_intermedio);
end;
/





--- EJERCICIO FECHA DE NACIMIENTO:

declare
    v_dia int;
    v_mes int;
    v_ano int;
begin
    v_dia := &dia;
    v_mes := &mes;
    v_ano := &ano;
    if ((v_mes +1)*3/5)then
    
end;


