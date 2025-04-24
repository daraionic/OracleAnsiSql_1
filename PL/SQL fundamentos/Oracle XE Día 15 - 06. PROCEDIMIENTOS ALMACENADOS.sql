---EJEMPLO DE PROCEDIMIENTOS ALMACENADOS

-- STORED PROCEDURE

create or replace procedure sp_mensaje
as
begin
    --MOSTRAMOS UN MENSAJE
    dbms_output.put_line ('Hoy es juerbes con música......');
end;

