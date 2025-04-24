---EJEMPLO DE PROCEDIMIENTOS ALMACENADOS

-- STORED PROCEDURE

create or replace procedure sp_mensaje
as
begin
    --MOSTRAMOS UN MENSAJE
    dbms_output.put_line ('Hoy es juerbes con música......');
end;

-- LLAMADA AL PROCEDIMIENTO

begin
    sp_mensaje;
end;

-- PROCEDIMEITNO CON BLOQUE PL/SQL

declare
    v_numero number;
begin
    v_numero := 14;
    if v_numero > 0 then
        dbms_output.put_line('Positivo');
    else
        dbms_output.put_line('Negativo');
    end if;
end;

-- CREAMOS EL PROCEDIMIENTO

create or replace procedure sp_ejemplo_plsql
as
begin
    -- PROCEDIMIENTO CON BLOQUE PL/SQL
    declare
        v_numero number;
    begin
        v_numero := 14;
        if v_numero > 0 then
            dbms_output.put_line('Positivo');
        else
            dbms_output.put_line('Negativo');
        end if;
    end;
end;

--LAMADA
begin
    sp_ejemplo_plsql;
end;


-- TENEMOS OTRA SINTAXIS PARA TENER VARIABLES DE UN PROCEDIMIENTO.LOGMNR$COL_GG_TABF_PUBLIC
-- NO SE UTILIZA LA PALABRA declare

create or replace procedure sp_ejemplo_plsql12
as
    v_numero number := 14;
begin
     if v_numero > 0 then
            dbms_output.put_line('Positivo');
    else
        dbms_output.put_line('Negativo');
    end if;
end;

begin
    sp_ejemplo_plsql12;
end;

-- PROCEDIMIENTO PARA SUMAR DOS NUMEROS

create or replace procedure sp_sumar_numeros
(p_numero1 number, p_numero2 number)
as
    v_suma number;
begin
    v_suma := p_numero1 + p_numero2;
    dbms_output.put_line ('La suma de ' || p_numero1 || ' + ' || p_numero2 || ' es: ' || v_suma);
end;

-- LLAMADA AL PROCEDIMIENTO
begin
    sp_sumar_numeros (5, 6);
end;

-- NECESITO UN PROCEDIMIENTO PARA DIVIDIR DOS NUMEROS
-- SE LLAMARA sp_dividir_numeros

create or replace procedure sp_dividir_numeros
(p_numero1 number, p_numero2 number)
as
    v_division number;
begin
    v_division := p_numero1 / p_numero2;
    dbms_output.put_line ('La división entre ' || p_numero1 || ' y ' || p_numero2 || ' es ' || v_division);
end;

begin
    sp_dividir_numeros (10, 0);
end;

-- VAMOS A CREAR UNA EXCEPCION DENTRO

-- NECESITO UN PROCEDIMIENTO PARA DIVIDIR DOS NUMEROS
-- SE LLAMARA sp_dividir_numeros

create or replace procedure sp_dividir_numeros
(p_numero1 number, p_numero2 number)
as
    v_division number;
begin
    v_division := p_numero1 / p_numero2;
    dbms_output.put_line ('La división entre ' || p_numero1 || ' y ' || p_numero2 || ' es ' || v_division);
exception
    when ZERO_DIVIDE then
        dbms_output.put_line ('División entre cero PROCEDURE');
end;

begin
    sp_dividir_numeros (10, 0);
end;

