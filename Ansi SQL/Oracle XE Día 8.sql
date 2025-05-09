------- DICCIONARIO DE DATOS:

Son consultas para ver objetos que tiene el usuario.

select * from USER_TABLES;

select * from EMP;

Tenemos 3 prefijos:

USER_  - Los objetos del esquema (=usuario=

ALL_  - Los objetos del esquema/usuario y de otros esquemas donde el user tiene 
privilegios.

DBA_  - Todos los objetos de la instacia.

select * from dba_tables;


--- Multitenant

CDB_  - Todos los objetos de todos los contenedores si la sesión está en el contenedor: cdb$root.
        Todos los objetos del contenedor en el que se encuentra la sesión, si es una PDB (Pluggable Database)

DBA_  - Todos los objetos del contenedor en el que se encuentra la sesión


Contenedor 1 > cdb$root

Contenedor 2 > pdb$seed

Contenedor 3 > PBDs

show con_id; (si es 0 no es multitenat)
show pdbs;


select * from user_tables;

select * from dict;

select * from dict where table_name like '%IND%';



--- TABLAS PRINCIPALES PARA CONSULTA/DESARROLLO

*_objects           - Todos los objetos
*_tables            - Las tablas
*_tab_columns       - Columnas de las tablas
*_constraints       - Todas las restricciones
*_cons_constraints  - Columnas con restricciones
*_viewsa            - Vistas
*_indexes           - Indices
*_ind_columns       - Columnas de los indices
*_synonyms          - Sinónimos
*_sequences         - Secuencias
*_tab_coments       - Comentarios de las tablas
*_col_comments      - Comentarios de las columnas de las tablas


select * from user_tab_columns where table_name='EMP' order by column_id;

select * from user_objects;

select * from user_constraints where table_name='EMP';
(R = FOREING KEY; P = PRIMARY KEY; C = CHECK; U = UNIQUE)

select * from user_cons_columns where table_name='EMP';
describe EMP;



---- V$
--- Son vistas de rendimiento

select * from v$session;
  -- Los usuarios sin privilegios no pueden verlas
  
select * from v$instance;

select * from v$database;


-- Comentarios

create table t1 (c1 number(3));

comment on table t1 is 'Es una tabla de prueba';

comment on column t1.c1 is 'Es la columna c1 de la tabla de prueba';


select * from user_tab_comments where table_name='T1';
select * from user_col_comments where table_name='T1';



-----

TABLESPACE
DATAFILES

SEGMENTS >>> EL NOMBRE DE ESPACIO QUE OCUPA UN OBJETO

EXTENS >>> CONJUNTO DE BLOUQES CONTINUOS EN UN DATA FILE

BLOCK >>> MINIMA UNIDAD DE ALMACENAMIENTO



select rowid, employee_id, first_name
from EMPLOYEES;

ROW ID no existe en la tabla, se genera en tiempo de consulta

ROW ID: Primeros 15 caracteres -> daa file y numero de bloque
        Posición de la fila denro del bloque



--- Practicas (HOJA 116 - https://baseinfo.es/cursos/24029_oracle/doc/sql/D108644GC10_ag.pdf)

1)
SELECT * FROM user_tables;

2)
SELECT table_name, owner
 FROM all_tables
 WHERE owner <>'ORA21';
 
 3)
SELECT column_name, data_type, data_length, data_precision PRECISION, 
data_scale SCALE, nullable
FROM user_tab_columns
WHERE table_name = UPPER('&tab_name');

SELECT column_name, data_type, data_length, data_precision PRECISION, 
data_scale SCALE, nullable
FROM user_tab_columns
WHERE table_name = UPPER('DEPARTMENTS');

4)

SELECT ucc.column_name, uc.constraint_name, uc.constraint_type,
 uc.search_condition, uc.status
FROM user_constraints uc JOIN user_cons_columns ucc
ON uc.table_name = ucc.table_name
AND uc.constraint_name = ucc.constraint_name
AND uc.table_name = UPPER('&tab_name');

SELECT ucc.column_name, uc.constraint_name, uc.constraint_type,
 uc.search_condition, uc.status
FROM user_constraints uc JOIN user_cons_columns ucc
ON uc.table_name = ucc.table_name
AND uc.constraint_name = ucc.constraint_name
AND uc.table_name = UPPER('DEPARTMENTS');

5)

COMMENT ON TABLE departments IS
 'Company department information including name, code, and location.';

SELECT COMMENTS
FROM user_tab_comments
WHERE table_name = 'DEPARTMENTS';

6)

create table DEPT2;

7)

SELECT table_name
FROM user_tables
WHERE table_name IN ('DEPT2', 'EMP2');

8)

SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name IN ('EMP2', 'DEPT2');

9)

SELECT object_name, object_type
FROM user_objects
WHERE object_name= 'EMP2'
OR object_name= 'DEPT2';





