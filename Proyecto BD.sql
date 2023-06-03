CREATE DATABASE Vende_todo
GO
CREATE TABLE proveedores(
	proveedor_id int NOT NULL PRIMARY KEY,
	nombre_compania varchar(30),
	direccion varchar(50),
	ciudad varchar(15),
	codigo_postal int,
	pais varchar(15),
	telefono int,
	email varchar(30),
	website varchar(30)
)
GO
CREATE TABLE empleados	(
	empleado_id int NOT NULL PRIMARY KEY,
	nombres varchar(30),
	apellidos varchar(50),
	fecha_nacimiento date,
	fecha_alta date,
	direccion varchar(50),
	ciudad varchar(15),
	nacionalidad varchar(15),
	dui int,
	telefono int
)
GO
CREATE TABLE cliente(
	cliente_id int NOT NULL PRIMARY KEY,
	empresa varchar(30),
	direccion varchar(50),
	ciudad varchar(15),
	codigo_postal int,
	pais varchar(15),
	telefono int,
	email varchar(30)
)
GO
CREATE TABLE empresas_de_envios(
	shipping_id int NOT NULL PRIMARY KEY,
	nombre_empresa varchar(30),
	telefono int,
	email varchar(30)
)
GO
CREATE TABLE productos(
	producto_id int NOT NULL PRIMARY KEY,
	nombre_producto varchar(30),
	unidades int,
	precio_unidad decimal,
	unidades_en_stock int,
	encargos_unidades int,
	proveedor_id int
)
GO
CREATE TABLE detalle_orden(
	precio_unitario decimal,
	unidades int,
	subtotal decimal,
	descuento decimal,
	iva decimal,
	total decimal,
	producto_id int,
	orden_id int
)
GO
CREATE TABLE detalle_envio(
	fecha_envio date,
	tipo_transporte varchar(15),
	vehiculo varchar(30),
	direccion varchar(50),
	ciudad_envio varchar(15),
	pais_envio varchar(15),
	codigo_postal int,
	shipping_id int,
	orden_id int
)
GO
CREATE TABLE orden_de_compra(
	orden_id int NOT NULL PRIMARY KEY,
	fecha_orden date,
	empleado_id int,
	cliente_id int
)
GO
ALTER TABLE productos ADD CONSTRAINT fk_productos_proveedor FOREIGN KEY (proveedor_id) REFERENCES proveedores(proveedor_id)
GO
ALTER TABLE detalle_orden ADD CONSTRAINT fk_detalle_orden_productos FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
GO
ALTER TABLE detalle_orden ADD CONSTRAINT fk_detalle_orden_orden FOREIGN KEY (orden_id) REFERENCES orden_de_compra(orden_id)
GO
ALTER TABLE detalle_envio ADD CONSTRAINT fk_detalle_envio_envio FOREIGN KEY (shipping_id) REFERENCES empresas_de_envios(shipping_id)
GO
ALTER TABLE detalle_envio ADD CONSTRAINT fk_detalle_envio_orden FOREIGN KEY (orden_id) REFERENCES orden_de_compra(orden_id)
GO
ALTER TABLE orden_de_compra ADD CONSTRAINT fk_orden_empleado FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id)
GO
ALTER TABLE orden_de_compra ADD CONSTRAINT fk_orden_cliente FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)

CREATE OR ALTER PROCEDURE dbo.sp_insertarCliente

	@cliente_id int,
	@empresa varchar(30),
	@direccion varchar(50),
	@ciudad varchar(15),
	@codigo_postal int,
	@pais varchar(15),
	@telefono int,
	@email varchar(30)

	AS

	BEGIN

	INSERT INTO dbo.cliente(cliente_id,empresa,direccion,ciudad,codigo_postal,pais,telefono,email)
	SELECT @cliente_id,@empresa,@direccion,@ciudad,@codigo_postal,@pais,@telefono,@email

	END

--EXEC [dbo].[sp_insertarCliente] 1,'Super Selectos','Avenida independencia','Santa Ana',503,'El Salvador',61258965,'superselectos@gmail.com'

CREATE OR ALTER PROCEDURE dbo.sp_insertarProducto

	@producto_id int,
	@nombre_producto varchar(30),
	@unidades int,
	@precio_unidad decimal,
	@unidades_en_stock int,
	@encargos_unidades int,
	@proveedor_id int

	AS

	BEGIN

	INSERT INTO [dbo].[productos](producto_id,nombre_producto,unidades,precio_unidad,unidades_en_stock,encargos_unidades,proveedor_id)
	SELECT @producto_id,@nombre_producto,@unidades,@precio_unidad,@unidades_en_stock,@encargos_unidades,@proveedor_id

	END
--EXEC [dbo].[sp_insertarProducto] 1,'Coca Cola',25,0.50,1000,2,1

CREATE OR ALTER PROCEDURE dbo.sp_insertarProveedor

	@proveedor_id int,
	@nombre_compania varchar(30),
	@direccion varchar(50),
	@ciudad varchar(15),
	@codigo_postal int,
	@pais varchar(15),
	@telefono int,
	@email varchar(30),
	@website varchar(30)

	AS

	BEGIN

	INSERT INTO [dbo].[proveedores](proveedor_id,nombre_compania,direccion,ciudad,codigo_postal,pais,telefono,email,website)
	SELECT @proveedor_id,@nombre_compania,@direccion,@ciudad,@codigo_postal,@pais,@telefono,@email,@website

	END

--EXEC [dbo].[sp_insertarProveedor] 1,'Coca Cola','Carretera a metapan','Santa Ana',503,'El Salvador','24402896','cocacola@gmail.com','cocacola.sv'
