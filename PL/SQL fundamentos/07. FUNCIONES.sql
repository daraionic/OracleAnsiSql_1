-------------- 07. FUNCIONES

-- Realizar una función para sumar dos números

create or replace function f_sumar_numeros
(p_numero1 number, p_numero2 number)
--SIEMPRE TIENE QUE TENER return Y EL TIPO DE DATO QUE DEVOLVERÁ
return number
as
    v_suma number;
begin
    v_suma := p_numero1 + p_numero2;
    --SIEMPRE UN RETURN
    return v_suma;
end;

--llamada con código PL/SQL

declare
    v_resultado number;
begin
    v_resultado := F_SUMAR_NUMEROS (22, 55);
    dbms_output.put_line ('La suma es ' || v_resultado);
end;

--llamada con select

select F_SUMAR_NUMEROS (22, 55) as SUMA from DUAL;


select apellido, F_SUMAR_NUMEROS (salario, comision) as total from EMP;



--QUIERO UNA FUNCION QUE NO DEVUELVA NULOS

create or replace function f_sumar_numeros_sin_nulos
(p_numero1 number, p_numero2 number)
return number
as
    v_suma number;
begin
    v_suma := nvl (p_numero1, 0) + nvl (p_numero2, 0);
    return v_suma;
end;


select apellido, F_SUMAR_NUMEROS_SIN_NULOS (salario, comision) as total from EMP;



-- FUNCION PARA SABER EL NRO DE PERSONAS DE OFICIO

create or replace function num_personas_oficio
(p_oficio EMP.OFICIO%TYPE)
return number
as
    v_personas int;
begin
    select count (EMP_NO) into v_personas from EMP
    where LOWER(OFICIO) = LOWER (p_oficio);
    return v_personas;
end;


select NUM_PERSONAS_OFICIO ('analista') as PERSONAS from DUAL;
create or replace function f_sumar_numeros
(p_numero1 number, p_numero2 number)
--SIEMPRE TIENE QUE TENER return Y EL TIPO DE DATO QUE DEVOLVERÁ
return number
as
    v_suma number;
begin
    v_suma := p_numero1 + p_numero2;
    --SIEMPRE UN RETURN
    return v_suma;
end;

--llamada con código PL/SQL

declare
    v_resultado number;
begin
    v_resultado := F_SUMAR_NUMEROS (22, 55);
    dbms_output.put_line ('La suma es ' || v_resultado);
end;

--llamada con select

select F_SUMAR_NUMEROS (22, 55) as SUMA from DUAL;


select apellido, F_SUMAR_NUMEROS (salario, comision) as total from EMP;



--QUIERO UNA FUNCION QUE NO DEVUELVA NULOS

create or replace function f_sumar_numeros_sin_nulos
(p_numero1 number, p_numero2 number)
return number
as
    v_suma number;
begin
    v_suma := nvl (p_numero1, 0) + nvl (p_numero2, 0);
    return v_suma;
end;


select apellido, F_SUMAR_NUMEROS_SIN_NULOS (salario, comision) as total from EMP;



-- FUNCION PARA SABER EL NRO DE PERSONAS DE OFICIO

create or replace function num_personas_oficio
(p_oficio EMP.OFICIO%TYPE)
return number
as
    v_personas int;
begin
    select count (EMP_NO) into v_personas from EMP
    where LOWER(OFICIO) = LOWER (p_oficio);
    return v_personas;
end;


select NUM_PERSONAS_OFICIO ('analista') as PERSONAS from DUAL;


-- Realizar una función para devolver el mayor de dos números

create or replace function num_mayor
(p_numero1 number, p_numero2 number)
return number
as
begin
    if p_numero1 > p_numero2 then
    return p_numero1;
    dbms_output.put_line ('El mayor es ' || p_numero1);
    else
    return p_numero2;
    dbms_output.put_line ('El mayor es ' || p_numero2);
    end if;
end;

select NUM_MAYOR (56, 55) as MAYOR from DUAL;



-- Realizar una funcion para devolver el mayor de 3 números
-- No quiero utilizar IF.
-- Buscar (Google) una funcion de Oracle que nos devulve el mayor...

CREATE OR REPLACE FUNCTION mayor_de_tres
    (num1 IN NUMBER,
    num2 IN NUMBER,
    num3 IN NUMBER)
    RETURN NUMBER IS
BEGIN
    RETURN GREATEST(num1, num2, num3);
END;

SELECT mayor_de_tres(10, 25, 17) AS resultado FROM dual;



--- Tenemos los parámetros por defecto dentro de las funciones

--DE CUANTO SERÁ EL IVA
select 100 * 0.21 as iva from DUAL;

--IMPORTE CON IVA:
select 100 * 1.21 as iva from DUAL;

select importe, iva(importe) as iva from productos; 

select importe, iva(importe, 21) as iva from productos; 

create or replace function calcular_iva
(p_precio number, p_iva number := 1.18)
return number
as
begin
    return p_precio * p_iva;
end;

-- SI LO PONEMOS COGE EL VALOR QUE PONEMOS
select CALCULAR_IVA (100, 1.21) as IVA from DUAL;
-- SINO AGARRA EL QUE TIENE LA FUNCION POR DEFECTO
select CALCULAR_IVA (100) as IVA from DUAL;

