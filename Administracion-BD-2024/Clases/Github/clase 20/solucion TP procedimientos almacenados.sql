--Solucion - Procedimientos Almacenados


--1)Crear un procedimiento almacenado en el esquema HumanResources que dada una determinada inicial, devuelva codigo, nombre, apellido y dirección de correo de los empleados cuyo nombre coincida con la inicial ingresada
--Vistas: HumanResources.vEmployee
--Campos: BusinessEntityID, FirstName, LastName, EmailAddress
CREATE PROCEDURE HumanResources.Empleado (@Inicial CHAR)
AS
	SELECT BusinessEntityID, FirstName, LastName, EmailAddress
	FROM HumanResources.vEmployee
	WHERE @Inicial= LEFT(FirstName,1);

EXECUTE HumanResources.Empleado 'A'
GO


--2)Crear un procedimiento almacenado llamado ProductoVendido que permita ingresar un producto como parámetro, si el producto ha sido vendido imprimir el mensaje “El PRODUCTO HA SIDO VENDIDO” de lo contrario imprimir 
--“El PRODUCTO NO HA SIDO VENDIDO” 
--Tablas: Sales.SalesOrderDetail
--Campos: ProductID

CREATE PROCEDURE dbo.ProductoVendido(@Producto INT)
AS
	IF EXISTS	( 
					SELECT	1 
					FROM	[Sales].[SalesOrderDetail] 
					WHERE	ProductID=@Producto
				)
		PRINT 'El PRODUCTO HA SIDO VENDIDO'
	ELSE 
		PRINT 'El PRODUCTO NO HA SIDO VENDIDO'

EXECUTE dbo.ProductoVendido 707;
GO


--3)Crear un procedimiento almacenado en el esquema dbo llamado ActualizaPrecio recibiendo como parámetros el producto y el precio
--Tablas: Production.Product
--Campos: ProductID, Name, ListPrice
CREATE PROCEDURE dbo.ActualizaPrecio(@Producto INT,@Precio  MONEY)
AS
	UPDATE Production.Product
	SET ListPrice=@Precio
	WHERE ProductID=@Producto;

	SELECT ProductID, Name, ListPrice
	FROM Production.Product
	WHERE ProductID=@Producto;

EXECUTE dbo.ActualizaPrecio 707, 500;
GO

--4)Crear un procedimiento almacenado llamado ProveedorProducto que devuelva los proveedores que proporcionan el producto especificado por parámetro. 
--Tablas: Purchasing.Vendor, Purchasing.ProductVendor, Production.Product
--Campos: Name
CREATE PROCEDURE dbo.ProveedorProducto(@Producto INT)
AS
	SELECT		pp.Name
	FROM		Purchasing.Vendor vd
	INNER JOIN  Purchasing.ProductVendor pv
	ON			vd.BusinessEntityID=pv.BusinessEntityID
	INNER JOIN	Production.Product pp
	ON			pv.ProductID=pp.ProductID
	WHERE		pp.ProductID=@Producto;

EXECUTE dbo.ProveedorProducto 707;
GO


--5)Crear un procedimiento almacenado  llamado EmpleadoSector que devuelva nombre, apellido y sector 
--del empleado que le pasemos como argumento.No es necesario apellido exacto al procedimiento.
--Vistas: HumanResources.vEmployeeDepartmentHistory
--Campos: FirstName, LastName, Department

CREATE PROCEDURE dbo.EmpleadoSector(@Apellido NVARCHAR(50)='%')
AS 
	SELECT	FirstName ,LastName,Department
    FROM	HumanResources.vEmployeeDepartmentHistory
    WHERE	LastName LIKE @Apellido

EXECUTE dbo.EmpleadoSector  'eric%'
EXECUTE dbo.EmpleadoSector 
GO