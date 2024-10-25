/*Trabajo Practico Manejo de variables

1. Obtener el total de ventas del año 2014 y guardarlo en una variable llamada @TotalVentas, luego imprimir el resultado.

Tablas: Sales.SalesOrderDetail
Campos: LineTotal
*/

use AdventureWorks


declare @@TotalVentas decimal(38,2);

set @@TotalVentas = (select round(sum(LineTotal), 0) from Sales.SalesOrderDetail where year(ModifiedDate) = 2007);

print @@TotalVentas;


/*2. Obtener el promedio de precios y guardarlo en una variable llamada @Promedio luego
hacer un reporte de todos los productos cuyo precio de venta sea menor al Promedio.

Tablas: Production.Product
Campos: ListPrice, ProductID*/

declare @promedio int;

set @promedio = (select cast(avg(ListPrice) as int) from Production.Product);

select ProductID,ListPrice from Production.Product where ListPrice < @promedio


/*3. Utilizando la variable @Promedio incrementar en un 10% el valor de los productos sean inferior al promedio.

Tablas: Production.Product
Campos: ListPrice*/


declare @promedio int;

set @promedio = (select cast(avg(ListPrice) as int) from Production.Product);

update Production.Product 
set listprice = listprice *1.1
where ListPrice < @promedio	

select * from Production.Product  where ProductID = 707

/*4. Crear un variable de tipo tabla con las categorías y subcategoría de productos y
reportar el resultado.

Tablas: Production.ProductSubcategory, Production.ProductCategory
Campos: Name*/

declare @tabla_categoria table (nombre_categoria varchar(150),
nombre_subcategoria varchar(150)
) ;

insert into @tabla_categoria (nombre_categoria, nombre_subcategoria ) select b.Name,a.name from Production.ProductSubcategory a
join Production.Productcategory b
on a.ProductCategoryID = b.ProductCategoryID

select * from @tabla_categoria



/*5. Analizar el promedio de la lista de precios de productos, si su valor es menor a 500 imprimir el mensaje el PROMEDIO BAJO de lo contrario imprimir el mensaje PROMEDIO ALTO.

Tablas: Production.Product
Campos: ListPrice */ 

DECLARE @mensaje VARCHAR(100);

SELECT @mensaje = 
    CASE 
        WHEN CAST(AVG(ListPrice) AS INT) < 500 THEN 'PROMEDIO BAJO'
        ELSE 'PROMEDIO ALTO'
    END
FROM Production.Product;

PRINT @mensaje;
