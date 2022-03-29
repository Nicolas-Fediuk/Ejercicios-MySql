/*4. La gestión de una farmacia necesita poder llevar control de los medicamentos
existentes, así como de los que se van vendiendo, para lo cual se pretende diseñar un
sistema acorde a las siguientes especificaciones:
En la farmacia se requiere una catalogación de todos los medicamentos existentes, para
lo cual se almacenará un código de medicamento, nombre del medicamento, tipo de
medicamento (jarabe, comprimido, pomada, etc.), unidades en stock, punto de pedido,
y precio. Existen medicamentos de venta libre, y otros que sólo pueden dispensarse con
receta médica.
La farmacia adquiere cada medicamento a un laboratorio y algunos los fabrica ella
misma. Se desea conocer el código del laboratorio, nombre, teléfono, dirección, fax así
como el nombre de la persona de contacto.
Los medicamentos se agrupan en familias, dependiendo del tipo de afección para las
que dicho medicamento se aplica (Ej.: analgésico, antiinflamatorio, antipirético). Un
medicamento puede pertenecer a más de una familia.
Se solicitan registrar las ventas.
Consultas:
4.1. Realizar una consulta que informe nombre del medicamento, nombre del
laboratorio y unidades en stock.
4.2. Realizar una consulta que informe nombre, unidades disponibles y precio unitario
de los artículos de un determinado laboratorio.
4.3. Realizar una consulta que informe nombre del medicamento, unidades en stock,
nombre y teléfono del laboratorio de todos aquellos productos que pasen su punto de
pedido.
4.4. Realizar una consulta que informe la mayor venta por tipo de medicamento
(jarabe, comprimido, pomada, etc.).*/

create database Farmacia;
use Farmacia;

create table Laboratorios(
Cod_lab char(10) primary key ,
Nombre_lab varchar(15) not null,
Telefono_lab int not null,
Direccion_lab varchar(20) null,
Fax_lab varchar(20) null
);

insert into Laboratorios(Cod_lab,Nombre_lab,Telefono_lab,Direccion_lab,Fax_lab)
values("cod1","farmacity",1123456789,"mitre 123","faxFamacia123");

insert into Laboratorios(Cod_lab,Nombre_lab,Telefono_lab,Direccion_lab,Fax_lab)
values("cod2","Bayer",110987643,"Sarmineto 12","faxSarmiento12"),
("cod3","Pratto",1149206395,"Obligado 1200","faxObligado1223");


create table TiposDeMedicamentos(
CodTipoMedicamento_tdm char(10) primary key,
Descripcion_tdm varchar(15) not null
);

insert into TiposDeMedicamentos(CodTipoMedicamento_tdm,Descripcion_tdm)
values ("CodTMed1","comprimido");

insert into TiposDeMedicamentos(CodTipoMedicamento_tdm,Descripcion_tdm)
values ("CodTMed2","jarabe"),
("CodTMed3","ponada");

create table Medicamentos(
Cod_med char(10) primary key,
Nombre_med varchar(30) not null,
Tipo_med char(10) not null,
Stock_med smallint not null,
CodLab_med char(10) null ,
Precio_med decimal(6,2) not null,
Receta_med bit not null,

foreign key (Tipo_med) references TiposDeMedicamentos(CodTipoMedicamento_tdm),
foreign key (CodLab_med) references Laboratorios(Cod_lab)
);

drop table Medicamentos;

insert into Medicamentos(Cod_med,Nombre_med,Tipo_med,Stock_med,CodLab_med,Precio_med,Receta_med)
values("CodMed1","ibuprofeno","CodTMed1",123,null,12,0),
("CodMed2","rengue","CodTMed3",5,"cod1",1500,1),
("CodMed3","pulmocler","CodTMed2",2,"cod3",780,1);

select * from Medicamentos;

create table Familias(
CodFamilia_f char(10) primary key,
Descripcion_f varchar(30) not null
);

insert into Familias(CodFamilia_f,Descripcion_f)
values("CodF1","analgesico"),
("CodF2","antiinflamatorio"),
("CodF3","antipiretico");

create table MedicamentosXfamilias(
CodMedicamento_mxf char(10),
CodFamilia_mxf char(10),

primary key(CodMedicamento_mxf,CodFamilia_mxf)
);

insert into MedicamentosXfamilias(CodMedicamento_mxf,CodFamilia_mxf)
values("CodMed1","CodF3"),
("CodMed2","CodF2"),
("CodMed3","CodF1");


create table Ventas(
NumFactura_v varchar(20) primary key,
FechaVenta_v datetime default now(),
Total_v decimal(6,2) default 0
);

insert into Ventas(NumFactura_v,Total_v)
values("venta1",12),
("venta2",1500),
("venta3",780);

select * from Ventas;

delete from Ventas where NumFactura_v != '';

create table DetallesDeVentas(
NumFactura_ddv varchar(20),
CodMedicamento_ddv char(10),
Precio_ddv decimal(6,2) not null,
CantidadVendida_ddv smallint not null,

primary key (NumFactura_ddv,CodMedicamento_ddv),
foreign key (NumFactura_ddv) references Ventas(NumFactura_v),
foreign key (CodMedicamento_ddv) references Medicamentos(Cod_med)
);

insert into DetallesDeVentas(NumFactura_ddv,CodMedicamento_ddv,Precio_ddv,CantidadVendida_ddv)
values ("venta1","CodMed1",12,1),
("venta2","CodMed2",1500,1),
("venta3","CodMed3",780,1);

select * from DetallesDeVentas;

##########################################

# 4.1. Realizar una consulta que informe nombre del medicamento, nombre del
# laboratorio y unidades en stock.

select Nombre_med,Stock_med,Nombre_lab from Medicamentos inner join Laboratorios
on Medicamentos.CodLab_med = Laboratorios.Cod_lab;

/*4.2. Realizar una consulta que informe nombre, unidades disponibles y precio unitario
de los artículos de un determinado laboratorio.*/

select Nombre_med,Stock_med,Precio_med from Medicamentos inner join Laboratorios
on Medicamentos.CodLab_med = Laboratorios.Cod_lab
where Cod_lab = 'cod1';

/*4.3. Realizar una consulta que informe nombre del medicamento, unidades en stock,
nombre y teléfono del laboratorio de todos aquellos productos que pasen su punto de
pedido.*/

select Nombre_med,Stock_med,Nombre_lab,telefono_lab from Medicamentos inner join Laboratorios
on Medicamentos.CodLab_med = Laboratorios.Cod_lab
/* suponiendo que el punto de pedido sea mayor a 2 , el medicamento con stock 123 no aparece porque lo 
fabrica la misma farmacia*/
where Stock_med > 1;

/*4.4. Realizar una consulta que informe la mayor venta por tipo de medicamento
(jarabe, comprimido, pomada, etc.).*/

select Cod_med, max(Total_v) from Ventas inner join DetallesDeVentas
on Ventas.NumFactura_v = DetallesDeVentas.NumFactura_ddv inner join Medicamentos
on DetallesDeVentas.CodMedicamento_ddv = Medicamentos.Cod_med
group by Cod_med;

