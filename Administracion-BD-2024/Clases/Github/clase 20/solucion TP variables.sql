--Solucion TP - Variables

--1)Obtener el total de ventas del año 2014 y guardarlo en una variable llamada @TotalVentas, luego imprimir el resultado.

--Tablas: Sales.SalesOrderDetail
--Campos: LineTotal

DECLARE @TotalVentas MONEY

SELECT	@TotalVentas=SUM(LineTotal)
FROM	Sales.SalesOrderDetail;

PRINT	@TotalVentas;



--2)Obtener el promedio de ventas y guardarlo en una variable llamada  @Promedio luego hacer un reporte de todos los productos cuyo precio de venta sea menor al Promedio.

--Tablas: Production.Product
--Campos: ListPrice, ProductID

DECLARE @Promedio MONEY

SELECT @Promedio=AVG(ListPrice)
FROM Production.Product

SELECT ListPrice, ProductID
FROM Production.Product
WHERE ListPrice<@Promedio


--3)Utilizando la variable @Promedio incrementar en un 10% el valor de los productos sean inferior al promedio.

--Tablas: Production.Product
--Campos: ListPrice

UPDATE Production.Product
SET ListPrice=ListPrice*1.10
WHERE ListPrice<@Promedio


--4)Crear un variable de tipo tabla con las categorías y subcategoría de productos y reportar el resultado.

--Tablas: Production.ProductSubcategory, Production.ProductCategory
--Campos: Name

DECLARE @VariableTabla TABLE(Categoria VARCHAR(50), SubCategoria VARCHAR(50)); 
INSERT INTO @VariableTabla
SELECT		pp.Name, ps.Name
FROM		Production.ProductSubcategory pp
INNER JOIN  Production.ProductCategory ps
ON			pp.ProductCategoryID=ps.ProductCategoryID;

SELECT * FROM @VariableTabla;

--5)Analizar el promedio de la lista de precios de productos, si su valor es menor a 500 imprimir el mensaje el PROMEDIO BAJO de lo contrario imprimir el mensaje PROMEDIO ALTO

IF (SELECT AVG(ListPrice) FROM Production.Product)<500
	PRINT 'PROMEDIO BAJO'
ELSE 
	PRINT 'PROMEDIO ALTO'