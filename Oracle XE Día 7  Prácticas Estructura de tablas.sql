
1) Crear la tabla COLEGIOS con los siguientes campos: 


create table COLEGIOS (COD_COLEGIO integer, NOMBRE varchar2(20) not null, 
LOCALIDAD varchar2(15), PROVINCIA varchar2(15), AÑO_CONSTRUCCION date, 
COSTE_CONSTRUCCION integer, COD_REGION integer, UNICO integer);

select * from COLEGIOS;

alter table COLEGIOS
add constraint PK_COLEGIOS
primary key (COD_COLEGIO);

alter table COLEGIOS
add constraint U_UNICO
unique (UNICO);

create sequence SEQ_COLEGIOS
increment by 1
start with 1;

insert into COLEGIOS values (SEQ_COLEGIOS.nextval, 'ARGENTINO', 'MADRID', 'MADRID', 
'01/01/2000', 1000000000, 13, 50);

select * from COLEGIOS;

2) Crear la tabla PROFESORES con los siguientes campos: 


create table PROFESORES (COD_PROFE varchar2(350) not null, NOMBRE varchar2 (350),
APELLIDO1 varchar2 (350), APELLIDO2 varchar2 (350), DNI char (9), EDAD integer, 
LOCALIDAD varchar2(350), PROVINCIA varchar2 (350), SALARIO integer, 
COD_COLEGIO integer);

alter table PROFESORES
add constraint PK_COD_PROFE
primary key (COD_PROFE);

alter table PROFESORES
modify (NOMBRE varchar2 (350) not null);

alter table PROFESORES
add constraint U_DNI
unique (DNI);

alter table PROFESORES
add constraint FK_PROFESORES_COLEGIOS
foreign key (COD_COLEGIO)
references COLEGIOS (COD_COLEGIO);


3) Crear la tabla REGIONES con los siguientes campos: 

create table REGIONES (COD_REGION integer, REGIONES varchar2 (20) not null);

alter table REGIONES
add constraint PK_COD_REGION
primary key (COD_REGION);

insert into REGIONES values (13, 'MADRID');


4) Crear la tabla ALUMNOS con los siguientes campos: 

create table ALUMNOS (DNI char (9) not null, NOMBRE varchar2 (350) not null, 
APELLIDOS varchar2 (350), FECHA_INGRESO date, FECHA_NAC date, LOCALIDAD varchar2 (15),
PROVINCIA varchar2 (30), COD_COLEGIO integer);

alter table ALUMNOS
add constraint PK_DNI
primary key (DNI);

alter table ALUMNOS
add constraint FK_ALUMNOS_COLEGIOS
foreign key (COD_COLEGIO)
references COLEGIOS (COD_COLEGIO);


5) Crear una nueva relación entre el campo Cod_Region de la tabla REGIONES y 
Cod_Region de la tabla colegios. 

alter table COLEGIOS
add constraint FK_COLEGIOS_REGIONES
foreign key (COD_REGION)
references REGIONES (COD_REGION);


6) Añadir el campo Sexo, Fecha de nacimiento y Estado Civil a la tabla Profesores. 


alter table PROFESORES
add (SEXO varchar2(1), FECHA_NACIMIENTO date, ESTADO_CIVIL varchar2 (20));


7) Eliminar el campo Edad de la tabla Profesores. 


alter table PROFESORES
drop column EDAD;


8)  Añadir el campo Sexo, Dirección y Estado Civil a la tabla Alumnos. 


alter table ALUMNOS
add (SEXO varchar2 (1), DIRECCION varchar2(350), ESTADO_CIVIL varchar2(350));


9) Borrar la relación existente entre la tabla profesores y Colegios. 


alter table PROFESORES
drop constraint FK_PROFESORES_COLEGIOS;


10) Crear de nuevo la relación borrada en el ejercicio anterior que tenga eliminación en cascada. 

alter table PROFESORES
add constraint FK_PROFESORES_COLEGIOS
foreign key (COD_COLEGIO)
references COLEGIOS (COD_COLEGIO)
on delete CASCADE;


11) Agregar un valor por defecto con la fecha actual al campo Fecha_Ingreso de la tabla alumnos. 

alter table ALUMNOS
add (FECHA_INGRESO date default sysdate);

alter table ALUMNOS
drop column FECHA_INGRESO;

describe ALUMNOS;


12) Queremos rellenar los datos de las tablas creadas, para ello vamos a 
introducir a tres alumnos en los colegios. Los datos son los siguientes: 

Ana Ortiz Ortega Provincia: Madrid Localidad: Madrid  

Javier Chuko Palomo Provincia: Alicante Localidad: Arenales del sol 

Miguel Torres Tormo Provincia: Barcelona Localidad: Llobregat 

delete from ALUMNOS where NOMBRE = 'ANA';

insert into ALUMNOS (DNI, NOMBRE, APELLIDOS, PROVINCIA, LOCALIDAD)
values ('55509912A', 'ANA', 'ORTIZ ORTEGA', 'MADRID', 'MADRID');

insert into ALUMNOS (DNI, NOMBRE, APELLIDOS, PROVINCIA, LOCALIDAD)
values ('66609912D', 'JAVIER', 'CHUKO PALOMO', 'ALICANTE', 'ARENALES DE SOL');

insert into ALUMNOS (DNI, NOMBRE, APELLIDOS, PROVINCIA, LOCALIDAD)
values ('77709912Y', 'MIGUEL', 'TORRES TORMO', 'BARCELONA', 'LLOBREGAT');



select * from ALUMNOS;
;
describe ALUMNOS;


13) Borrar la tabla Regiones.  

drop table REGIONES;

drop table REGIONES cascade constraint;



14) Borrar todas las tablas.

drop table COLEGIOS cascade constraint;
drop table PROFESORES cascade constraint;
drop table ALUMNOS cascade constraint;




