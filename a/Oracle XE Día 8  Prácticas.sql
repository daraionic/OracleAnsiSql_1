
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




