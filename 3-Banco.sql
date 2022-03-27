/* 3. Se desea diseñar una base de datos para una entidad bancaria que contenga
información sobre los clientes, las cuentas, las sucursales y las transacciones
producidas. Construir el modelo E/R teniendo en cuenta las siguientes
restricciones:
Un cliente puede tener muchas cuentas.
Una cuenta puede tener muchos clientes.
Una cuenta sólo puede pertenecer a una sucursal, aunque otra sucursal tenga el
mismo número de cuenta.
En una transacción se registrará el número de transacción, el número de cuenta,
la fecha y el monto entre otros.
3.1. Realizar una base de datos normalizada que contenga los siguientes campos
entre otros que deberá definir usted.
Nombre
Apellido
DNI
Dirección
Cuenta
Tipo de Cuenta (Caja de ahorro – Plazo fijo)
Sucursal
Dirección Sucursal
Saldo cuenta
Transacción (Extracción – Depósito - Movimiento)
Deberá mantener el registro de la Cuenta principal y el CBU de la Cuenta destino
en caso de que la operación lo requiera.
3.2. Consultas
1. Realizar una consulta que informe Sucursales
2. Realizar una consulta que informe los datos de un cliente específico con su
respectiva sucursal
3. Realizar una consulta que informe los datos de un cliente específico con sus
respectivas cuentas
4. Realizar una consulta que informe la mayor transacción y los datos del cliente
5. Realizar una consulta que informe los datos de un cliente específico con sus
respectivas cuentas, sucursales y saldos. */

create database Banco;

use Banco;

create table Clientes(
Dni_cli varchar(9) primary key,
Nombre_cli varchar(20) not null,
Apellido_cli varchar(20) not null,
Direccion_cli varchar(50) not null
);

create table Sucursal
(
CodSucursal_s varchar(40) primary key,
Direccion varchar(40) not null
);

create table Cuentas(
CodCuenta_c varchar(40),
CodSucursal_c varchar(40),
Tipo_c bit not null,
Saldo_c decimal(10,2) not null,
primary key (CodCuenta_c,CodSucursal_c),
foreign key (CodSucursal_c) references Sucursal(CodSucursal_s)
);

create table CuentasXclientes(
CodSucursal_cxc varchar(40),
CodCuenta_cxc varchar(40),
DniCliente_cxc varchar(9),
primary key (CodSucursal_cxc,CodCuenta_cxc,DniCliente_cxc),
foreign key (CodSucursal_cxc,CodCuenta_cxc) references Cuentas(CodSucursal_c,CodCuenta_c),
foreign key (DniCliente_cxc) references Clientes(Dni_cli)
);

drop table CuentasXclientes;

create table Transacciones(
NumeroTransaccion_t varchar(50) primary key,
dniCliente_t varchar(9),
CodCuenta_t varchar(40),
CodSucursal_t varchar(40),
TipoTransaccion_t varchar(12) not null,
Monto_t decimal(10,2) not null,
Destino_t varchar(40) not null,
foreign key (CodCuenta_t,CodSucursal_t) references Cuentas(CodCuenta_c,CodSucursal_c),
foreign key (dniCliente_t) references Clientes(Dni_cli)
);

insert into Clientes (Dni_cli,Nombre_cli,Apellido_cli,Direccion_cli)
values('41542382','nicolas','fediuk','pacifico 336'),
('12345678','andrea','quinteros','bs 2110');

insert into Sucursal(CodSucursal_s,Direccion)
values('sucu1','Alvarado 12'),
('sucu2','mitre 1020');

insert into Cuentas(CodCuenta_c,CodSucursal_c,Tipo_c,Saldo_c)
values('123','sucu1',true,23456),
('456','sucu2',false,78956);

insert into CuentasXclientes(CodSucursal_cxc,CodCuenta_cxc,DniCliente_cxc)
values('sucu1','123','41542382'),
('sucu2','456','12345678');

insert into Transacciones(NumeroTransaccion_t,DniCliente_t,CodCuenta_t,TipoTransaccion_t,Monto_t,Destino_t)
values('123456','41542382','123','deposito',3456,'cuenta1'),
('7890','12345678','456','movimiento',67890,'cuenta23');

/* 1. Realizar una consulta que informe Sucursales */
select CodSucursal_s from Sucursal;

/* 2. Realizar una consulta que informe los datos de un cliente específico con su
respectiva sucursal*/
select Dni_cli,Nombre_cli,Apellido_cli,Direccion_cli,CodSucursal_cxc from Clientes inner join cuentasXclientes
on Clientes.Dni_cli = cuentasXclientes.DniCliente_cxc 
where DniCliente_cxc = '41542382';

/*3. Realizar una consulta que informe los datos de un cliente específico con sus
respectivas cuentas*/
select Dni_cli,Nombre_cli,Apellido_cli,Direccion_cli,CodCuenta_cxc from Clientes inner join cuentasXclientes
on Clientes.Dni_cli = cuentasXclientes.DniCliente_cxc 
where DniCliente_cxc = '41542382';

/*4. Realizar una consulta que informe la mayor transacción y los datos del cliente*/
select Nombre_cli, max(monto_t) from Clientes inner join Transacciones
on Clientes.Dni_cli = Transacciones.DniCliente_t
group by Nombre_cli;

/*5. Realizar una consulta que informe los datos de un cliente específico con sus
respectivas cuentas, sucursales y saldos.*/
select Dni_cli,Nombre_cli,Apellido_cli,Direccion_cli,CodCuenta_cxc,CodSucursal_cxc,Saldo_c from Clientes inner join cuentasXclientes
on Clientes.Dni_cli = cuentasXclientes.DniCliente_cxc inner join Cuentas
on  cuentasXclientes.CodCuenta_cxc = Cuentas.CodCuenta_c
where Dni_cli = '41542382';






