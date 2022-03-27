/*2. La empresa “Pacheco” desea llevar un registro digital del stock de los
artículos de la empresa y sus proveedores respectivos, siendo que un artículo
puede tener más de un proveedor y un proveedor tiene varios artículos.
Los datos disponibles para los proveedores son los siguientes: razón social,
dirección, ciudad, provincia, cuit, teléfono, contacto, web, mail.
Los datos disponibles para los artículos son los siguientes: nombre, cantidad,
precio unitario.
Consultas:
2.1. Realizar una consulta que informe razón social, ciudad y provincia de las
empresas ubicadas en Buenos Aires.
2.2. Realizar una consulta que informe el código de artículo y el nombre,
ordenados según código de artículo en forma descendente.
2.3. Realizar una consulta que informe las provincias en las que hay
proveedores.
2.4. Realizar una consulta que informe el nombre de los artículos y la cantidad
de dinero de estos en stock (cantidad X precio unitario).
2.5. Realizar una consulta que informe nombre, cantidad y precio unitario de
los artículos de un determinado proveedor.*/

create database Comercio;

use Comercio;

create table Proveedores(
CUIT_pro varchar(11) primary key,
RazonSocial_pro varchar(20) not null,
Direccion_pro varchar(30) not null,
Cuidad_pro varchar(30) not null,
Provincia_pro varchar(20) not null,
Telefono_pro bigint not null,
Contacto_pro varchar(30) null,
Web_pro varchar(30) null,
Mail_pro varchar(30) null
);

create table Articulos(
CodArticulo_art char(4) primary key,
Nombre_art varchar(30) not null,
Cantidad_art varchar(6) not null,
PrecioUnitario_art decimal(9,2) not null check(PrecioUnitario_art > 0)
);

drop table Articulos;

create table ProveedoresXarticulos(
CuitProveedor_pxa varchar(11),
CodArticulo_pxa char(4),
primary key(CuitProveedor_pxa,CodArticulo_pxa),
foreign key (CuitProveedor_pxa) references Proveedores(CUIT_pro),
foreign key (CodArticulo_pxa) references Articulos(CodArticulo_art)
);

insert into Proveedores(CUIT_pro,RazonSocial_pro,Direccion_pro,Cuidad_pro,Provincia_pro,Telefono_pro,Contacto_pro,Web_pro,Mail_pro)
values('123','arcor','sarmiento 930','san pedro','bs as',3329456701,'3329457236',null,'juanarcor@gmail.com'),
('456','pepsico','mitre 20','san pedro','bs as',33329034812,'pepsico@gmail.com','pepsico.com','pedro@gmail.com');

select * from Proveedores;

insert into Articulos(CodArticulo_art,Nombre_art,Cantidad_art,PrecioUnitario_art)
values('art1','alfajor',200,20),
('art2','pepsi',20,150);

select * from Articulos;

insert into ProveedoresXarticulos(CuitProveedor_pxa,CodArticulo_pxa)
values('123','art2'),
('456','art1');

select * from ProveedoresXarticulos;

#################################################

#2.1
select RazonSocial_pro, Cuidad_pro from Proveedores
where Provincia_pro = 'bs as';

#2.2
select CodArticulo_art, Nombre_art from Articulos
order by CodArticulo_art desc;

#2.3
select Provincia_pro as provicia_con_proveedores from Proveedores
where CUIT_pro != '';

#2.4
select Nombre_art, (Cantidad_art * PrecioUnitario_art) as dinero_producto_stock from Articulos;

#2.5
select Nombre_art,Cantidad_art,PrecioUnitario_art from Articulos
inner join ProveedoresXarticulos
where CuitProveedor_pxa = '123';

