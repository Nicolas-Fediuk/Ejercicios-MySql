/*1. Se requiere diseñar una base de datos para una aplicación de gestión de
una institución escolar que permita administrar los profesores, los cursos y
los alumnos, teniendo en cuenta las siguientes restricciones:
 Un profesor podrá dictar varios cursos.
 Un curso tiene únicamente un profesor.
 Un curso puede tener muchos alumnos y un alumno puede asistir a
muchos cursos.
Realice el DER (Diagrama Entidad Relación) de la base de datos.
Consultas:
1.1. Realizar una consulta que informe todos los profesores de la
institución.
1.2. Realizar una consulta que informe el DNI del alumno y su nombre.
1.3. Realizar una consulta que informe el apellido de un determinado DNI o
legajo docente.*/

create database InstitucionEscolar;

use InstitucionEscolar;

create table Profesores(
idProfesor_pro smallint auto_increment primary key,
Nombre_pro varchar(20),
Apellido_pro varchar(20),
Direccion_pro varchar(40),
Telefono_pro int,
Correo_pro varchar(40)
);

create table Cursos(
CodCurso_cur char(5) primary key,
Nombre_cur varchar(30),
Profesor_cur smallint,
CargaHoraria_cur smallint,
foreign key (Profesor_cur) references Profesores (idProfesor_pro)
);

create table Alumnos(
Legajo_alum varchar(10) primary key,
Nombre_alum varchar(20),
Apellido_alum varchar(20),
Direccion_alum varchar(40),
Telefono_alum int,
Correo_alum varchar(40)
);

create table AlumnosXcursos(
LegaloAlumno_alumXcur varchar(10),
CodigoCurso_alumXcur char(5),
primary key (LegaloAlumno_alumXcur,CodigoCurso_alumXcur),
foreign key (LegaloAlumno_alumXcur) references Alumnos (Legajo_alum),
foreign key (CodigoCurso_alumXcur) references Cursos (CodCurso_cur)
);

insert into Profesores(Nombre_pro,Apellido_pro,Telefono_pro,Correo_pro)
values('Juan','Diaz',332934567,'juandiaz@gmail.com'),
('Ana','Felix',332956035,'anafelix@gmail.com'),
('Pedro','Pascal',332900456,'pedropascal@gmail.com');

select * from Profesores;

insert into Alumnos(Legajo_alum,Nombre_alum,Apellido_alum,Direccion_alum,Telefono_alum ,Correo_alum)
values(1,'Juan','Fer','Pasco 2110',33294568,'juan@gmail.com'),
(2,'Ramon','Caballero','swifi 12',332930471,'ramon@gmail.com');

select * from Alumnos;

insert into Cursos(CodCurso_cur,Nombre_cur,Profesor_cur,CargaHoraria_cur)
values('cur1','matematica',1,4),
('cur2','fisica',3,2);

select * from Cursos;

insert into AlumnosXcursos(LegaloAlumno_alumXcur,CodigoCurso_alumXcur)
values(1,'cur2'),
(2,'cur1');

select * from AlumnosXcursos;

###############################################

#1.1
select Nombre_pro from Profesores;

#2.2
select Legajo_alum, Nombre_alum from Alumnos;

#3.3
select Apellido_pro from Profesores
where  idProfesor_pro = 1;


