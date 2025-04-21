-------------- BUCLES

------ VAMOS A MOSTRAR LA SUMA DE LOS PRIMEROS 100 NUMEROS

--- 1) LOOP .. END LOOP

declare
    --variables contador suelen denominarse con una sola letra: i, z, k
    i int;
    suma int;
begin
    
end;


declare 
    i integer; 
    suma real; 
begin 
    suma:=0; 
    i:=1; 
    loop 
    suma:=suma+i; 
    i:=i+1; 
    exit when i>1000; 
    end loop; 
 dbms_output.put_line('la suma de los 1000 primeros numeros naturales es '||suma); 
end; 