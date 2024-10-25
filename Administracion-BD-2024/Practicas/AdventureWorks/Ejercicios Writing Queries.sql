/*   SELECT - WHERE */

--1. mostrar los empleados que tienen mas de 90 horas de vacaciones 
select p.FirstName, p.LastName from [HumanResources].[Employee] e
		join Person.Person p on e.BusinessEntityID = p.BusinessEntityID;

--2. mostrar el nombre, precio y precio con iva de los productos fabricados
select name as 'Nombre'
,ListPrice * 1.21 as 'Precio con IVA'
,ListPrice as 'Precio de Lista'
from production.Product;

--3. mostrar los diferentes titulos de trabajo que existen
select distinct JobTitle from [HumanResources].[Employee]

--4. mostrar todos los posibles colores de productos 
select distinct color from Production.product

--5. mostrar todos los tipos de pesonas que existen 
select distinct PersonType from [Person].[Person]

--6. mostrar el nombre concatenado con el apellido de las personas cuyo apellido sea johnson
select concat(FirstName,' ',LastName) as 'NombreCompleto' from person.Person where LastName = 'Johnson'

--7. mostrar todos los productos cuyo precio sea inferior a 150$ de color rojo o cuyo precio sea mayor a 500$ de color negro
select * from Production.product where (ListPrice < 150 and color = 'Red') or (ListPrice > 500 and color = 'Black')

--8. mostrar el codigo, fecha de ingreso y horas de vacaciones de los empleados ingresaron a partir del año 2000 
select HireDate, BusinessEntityID, VacationHours from HumanResources.Employee
where Year(HireDate) > 2000

--9. mostrar el nombre,nmero de producto, precio de lista y el precio de lista incrementado en un 10% de los productos cuya fecha de fin de venta sea anerior al dia de hoy
select name, ProductNumber,ListPrice,ListPrice * 1.1 as 'Precio Incrementado' from Production.Product
where SellEndDate <= GETDATE()

/* CONSULTAS CON BETWEEEN & IN   */

--10. mostrar todos los porductos cuyo precio de lista este entre 200 y 300 
select name from production.product where ListPrice between 200 and 300 

--11. mostrar todos los empleados que nacieron entre 1970 y 1985 
select * from humanresources.Employee
where year(birthdate) between 1970 and 1985

--12. mostrar los codigos de venta y producto,
--cantidad de venta y precio unitario de los articulos 750,753 y 770 
select SalesOrderID, productid, orderqty,unitprice 
from sales.SalesOrderDetail
where ProductID in (750,753,770)

--13. mostrar todos los porductos cuyo color sea verde, blanco y azul 

select * from [Production].[Product]
where Color in ('White', 'Blue','Green')

--14. mostrar el la fecha,nuero de version y subtotal de las ventas efectuadas en los años 2005 y 2006 
select cast(OrderDate as DATE) Fecha, RevisionNumber as Numero_DE_VERSION, sum(subtotal)
--Numer de version, fecha, subtotal de ls ventas
from Sales.SalesOrderHeader
WHERE year(OrderDate) between 2005 and 2006
group by cast(OrderDate as DATE),RevisionNumber

/* CONSULTAS CON LIKE */

--15. mostrar el nombre, precio y color de los accesorios para asientos de las bicicletas cuyo precio sea  mayor a 100 pesos

select name, color,ListPrice from Production.Product where ListPrice >= 100 and name like '%seat%'

--16. Mostrar las bicicletas de montaña que  cuestan entre $1000 y $1200 
select	* 
from	Production.Product
where	ProductNumber like 'bk%' 
and		ListPrice between 1000 and 1200

--17. mostrar los nombre de los productos que tengan cualquier combinacion de ‘mountain bike’ 
select * from Production.Product where name like '%mountain bike%'

--18. mostrar las personas que su nombre empiece con la letra 'y'
select * from Person.person where FirstName like 'y%'

--19. mostrar las personas que la segunda letra de su apellido es una 's'
select * from Person.person where SUBSTRING(LastName, 2, 1) = 'S'

--20. mostrar el nombre concatenado con el apellido de las personas cuyo apellido tengan terminacion española (ez)
select concat(FirstName, ' ' ,LastName)  from Person.person where LastName like '%ez'

--21. mostrar los nombres de los productos que su nombre termine en un numero 
SELECT *
FROM Production.Product
WHERE RIGHT(name, 1) BETWEEN '0' AND '9';

SELECT Name
FROM Production.Product
WHERE Name LIKE '%[0-9]';


--22. mostrar las personas cuyo  nombre tenga una c o C como primer caracter, cualquier otro como segundo caracter, ni d ni D ni f ni g como tercer caracter, cualquiera entre j y r o entre s y w como cuarto caracter y el resto sin restricciones 

select	distinct FirstName as Persona
from	Person.Person
where	FirstName like '[c,C]_[^dDfg][j-r,s-w]%'

/*  CONSULTAS CON ORDER BY  */

--23. mostrar las personas ordernadas primero por su apellido y luego por su nombre
select * from person.Person order by LastName , FirstName

-- 24. Mostrar los cinco productos mas caros y su nombre ordenado en forma alfabetica
select		top 5 *
from		Production.Product
order by	listPrice desc, Name


/*  FUNCIONES DE AGRUPACION  */ 

--25. Mostrar la fecha mas reciente de venta 
select	max(orderDate) [fecha mas reciente]
from	Sales.SalesOrderHeader

select	*
from	Sales.SalesOrderHeader
where	OrderDate = (select MAX(OrderDate) from Sales.SalesOrderHeader)

-- 26. Mostrar el precio mas barato de todas las bicicletas
select	min(ListPrice) 
from	Production.Product
where	ProductNumber like 'bk%'


/*  CONSULTAS CON NULL */

--28. Mostrar los representantes de ventas (vendedores) que no tienen definido el numero de territorio
select	*
from	Sales.SalesPerson
where	TerritoryID is null

--29. Mostrar el peso promedio de todos los articulos. si el peso no estuviese definido, reemplazar por cero
select		avg(isnull(Weight,0))
from		Production.Product

/*   CONSULTAS CON GROUP BY   */

--30. mostrar el codigo de subcategoria y el precio del producto mas barato de cada una de ellas 
select ProductSubcategoryID, min(listprice) from Production.Product 
group by ProductSubcategoryID


--31. Mostrar los productos y la cantidad total vendida de cada uno de ellos
select		ProductID as Producto,
			sum(OrderQty) as 'Cantidad vendida'
from		Sales.SalesOrderDetail
group by	ProductID
order by	2 desc

--32. mostrar los productos y la cantidad total vendida de cada uno de ellos, ordenarlos por mayor cantidad de ventas
select ProductID, sum(orderqty) from sales.SalesOrderDetail 
group by ProductID
order by sum(orderqty) desc

--33. Mostrar todas las facturas realizadas y el total facturado de cada una de ellas ordenado por numero de factura.
select		ProductID as Producto,
			sum(unitPrice * OrderQty) as 'Total Facturado'
from		Sales.SalesOrderDetail
group by	ProductID
order by	2 desc

/*  CONSULTAS CON HAVING  */ 

--34. Mostrar todas las facturas realizadas y el total facturado de cada una de ellas ordenado por nro de factura pero solo de aquellas ordenes superen un total de $10.000
select		SalesOrderDetailID as [Nro de Factura],
			sum(unitPrice * OrderQty) as 'Total Facturado'
from		Sales.SalesOrderDetail
group by	SalesOrderDetailID
having		sum(unitPrice * OrderQty) > 10000
order by	1

--34BIS. Mostrar todas las facturas realizadas y el total facturado de cada una de ellas ordenado por nro de factura pero solo de aquellas ordenes superen un total de $10.000 
select		p.Name as Producto,
			p.ProductID as Codigo,
			sum(UnitPrice *  OrderQty) 'Total Facturado',
			DATEDIFF(WEEK, p.SellStartDate, p.SellEndDate) as 'Tiempo de Venta en Semanas'
from		Sales.SalesOrderDetail sod
inner join	Production.Product p
on			p.ProductID = sod.ProductID
where		DATEDIFF(WEEK, p.SellStartDate, p.SellEndDate) is not null
group by	p.Name, p.ProductID,DATEDIFF(WEEK, p.SellStartDate, p.SellEndDate) 
having		sum(UnitPrice *  OrderQty) > 10000
order by	4 desc

--35. Mostrar la cantidad de facturas que vendieron mas de 20 unidades 
select		ProductID as Producto,
			sum(OrderQty) as 'Cantidad vendida'
from		Sales.SalesOrderDetail
group by	ProductID
having		sum(OrderQty) > 20
order by	2 desc

--36. mostrar las subcategorias de los productos que tienen dos o mas productos que cuestan menos de $150 
select  ProductSubcategoryID ,count(*) from Production.Product
where StandardCost < 150
group by ProductSubcategoryID
having count(*) >=2


--37. Mostrar todos los codigos de categorias existentes junto con la cantidad de productos y el precio de lista promediopor cada uno de aquellos productos que cuestan mas de $70 y el precio promedio es mayor a $300 
select		ProductSubcategoryID [Categoria de Producto],
			count(ProductID) Cantidad,
			avg(ListPrice) Promedio
from		Production.Product
where		ListPrice > 70
group by	ProductSubcategoryID
having		avg(ListPrice) > 300
order by	1

/*compute NO SE HACE MAS

38. mostrar numero de factura, el monto vendido y al final totalizar la facturacion 
*/

/*   CONSULTAS CON JOINS   */ 
--39. Mostrar los empleados que también son vendedores 
select		e.*
from		HumanResources.Employee e
inner join	Sales.SalesPerson sp
on			e.BusinessEntityID = sp.BusinessEntityID

--40. Mostrar  los empleados ordenados alfabeticamente por apellido y por nombre 
select		p.FirstName + ' ' + p.LastName as Empleado    
			,e.*
from		HumanResources.Employee e
inner join	Person.Person p
on			e.BusinessEntityID = p.BusinessEntityID
order by	1

--41. mostrar el codigo de logueo, numero de territorio y sueldo basico de los vendedores 
SELECT a.LoginID ,
       d.TerritoryID,
       g.Rate
FROM HumanResources.Employee a
JOIN Person.Person b ON a.BusinessEntityID = b.BusinessEntityID
JOIN Sales.SalesPerson c ON b.BusinessEntityID = c.BusinessEntityID
JOIN Sales.SalesTerritory d ON c.TerritoryID = d.TerritoryID
JOIN HumanResources.EmployeePayHistory g ON a.BusinessEntityID = g.BusinessEntityID

--42. Mostrar los productos que sean ruedas 
select		ps.Name as Producto
			,p.*
from		Production.Product p
inner join	Production.ProductSubcategory ps
on			ps.ProductSubcategoryID  = p.ProductSubcategoryID 
where		ps.Name = 'Wheels'
order by	1

--43. Mostrar los nombres de los productos que no son bicicletas 
select		ps.Name as Producto
			,p.*
from		Production.Product p
inner join	Production.ProductSubcategory ps
on			ps.ProductSubcategoryID  = p.ProductSubcategoryID 
where		ps.Name not like '%bike%'
order by	1

-- 44. Mostrar los precios de venta de aquellos  productos donde el precio de venta sea inferior al precio de lista recomendado para ese producto ordenados por nombre de producto
select		p.Name as Producto
			,p.ListPrice as [Precio de Lista]
			,sod.UnitPrice as [Precio Unitario]
from		Production.Product p
inner join	Sales.SalesOrderDetail sod
on			p.ProductID = sod.ProductID
where		sod.UnitPrice < p.ListPrice
order by	1


--45. mostrar todos los productos que tengan igual precio. Se deben mostrar de a pares. codigo y nombre de cada uno de los dos productos y el precio de ambos. ordenar por precio en forma descendente 
select p1.listprice, p1.productid,p1.name, p2.productid , p2.name
from Production.Product p1
join Production.Product p2 on  p1.ListPrice = p2.ListPrice
where p1.productid < p2.productid
order by listprice desc


--46.mostrar todos los productos que tengan igual precio. Se deben mostrar de a pares. codigo y nombre de cada uno de los dos productos y el precio de ambos mayoes a $15
select p1.listprice, p1.productid,p1.name, p2.productid , p2.name
from Production.Product p1
join Production.Product p2 on  p1.ListPrice = p2.ListPrice
where 
  p1.ProductID < p2.ProductID
    AND p1.ListPrice > 15
    AND p2.ListPrice > 15

--47.mostrar el nombre de los productos y de los proveedores cuya subcategoria es 15 ordenados por nombre de proveedor 
select a.name as nombre_producto, c.name as nombre_proveedor from Production.Product a
join Purchasing.ProductVendor b on a.ProductID = b.ProductID
join Purchasing.Vendor c on b.BusinessEntityID = c.BusinessEntityID
where a.ProductSubcategoryID = 15 
order by 2

--48.mostrar todas las personas (nombre y apellido) y en el caso que sean empleados mostrar tambien el login id, sino mostrar null 
select a.FirstName, a.LastName, b.LoginID
FROM Person.Person a
LEFT JOIN  HumanResources.Employee b ON a.BusinessEntityID = b.BusinessEntityID;

--49. Mostrar los vendedores (nombre y apellido) y el territorio asignado a c/u(identificador y nombre de territorio). En los casos en que un territorio no tiene vendedores mostrar igual los datos del territorio unicamente sin datos de vendedores
select		p.FirstName + ' ' + p.LastName as Vendedor
			,st.TerritoryID as identificador
			,st.Name as Territorio
from		Sales.SalesTerritory st
left join	Sales.SalesPerson sp
on			st.TerritoryID = sp.TerritoryID
inner join	Person.Person p
on			p.BusinessEntityID = sp.BusinessEntityID

--49 BIS. Mostrar los vendedores (nombre y apellido) y el territorio asignado a c/u(identificador y nombre de territorio). En los casos en que un vendedor no tenga territorio mostrar igual los datos del vendedor unicamente sin datos de territorios
-- tabla ppal: SalesPerson
-- tabla secundaria: SalesTerritory
select		st.TerritoryID 'Identificador de Territorio',
			st.Name as 'Territorio de Venta',
			p.FirstName + ' ' + p.LastName as Vendedor
from		Person.Person p
inner join	Sales.SalesPerson sp
on			p.BusinessEntityID = sp.BusinessEntityID
left join	Sales.SalesTerritory st
on			st.TerritoryID = sp.TerritoryID
where		st.TerritoryID is null

--50. Mostrar el producto cartesiano ente la tabla de vendedores cuyo numero de identificacion de negocio sea 280 y el territorio de venta sea el de francia 
select		sp.BusinessEntityID as [numero de identificacion]
			,st.Name as 'Territorio de venta'
			,sp.*
from		Sales.SalesPerson sp
cross join	Sales.SalesTerritory st
where		st.Name = 'France' and sp.BusinessEntityID = 280


--50 BIS. Mostrar el producto cartesiano ente la tabla de vendedores cuyo numero de identificacion de negocio sea 280 y el territorio de venta sea el de francia 
select		sp.BusinessEntityID as 'Numero de Identificacion',
			st.Name as 'Territorio de Venta',
			p.FirstName + ' ' + p.LastName as Vendedor
from		Sales.SalesPerson sp
inner join	Person.Person p 
on			p.BusinessEntityID = sp.BusinessEntityID
cross join	Sales.SalesTerritory st
where		st.Name = 'France' and sp.BusinessEntityID = 280


/* SUBCONSULTAS  */
--51.listar todos las productos cuyo precio sea inferior al precio promedio de todos los productos 
SELECT ProductID, Name, ListPrice
FROM Production.Product
WHERE  ListPrice < (
					SELECT AVG(ListPrice) FROM Production.Product
					);

--52.listar el nombre, precio de lista, precio promedio y diferencia de precios entre cada producto y el valor promedio general 
SELECT 
    Name,
    ListPrice,
    (SELECT AVG(ListPrice) FROM Production.Product) AS Precio_Promedio,
    ListPrice - (SELECT AVG(ListPrice) FROM Production.Product) AS Diferencia_Precio
FROM 
    Production.Product;


--53. mostrar el o los codigos del producto mas caro 
SELECT ProductID AS Codigo_Producto, ListPrice AS Precio
FROM Production.Product
where ListPrice = (select max(listprice) from Production.Product)



-- 54. mostrar el producto mas barato de cada subcategoría. mostrar subcaterogia, codigo de producto y el precio de lista mas barato ordenado por subcategoria 
select	 p1.ProductID 'Codigo de Producto',
		 p1.ListPrice 'Precio de Lista',
		 p1.ProductSubcategoryID 'Codigo de Subcategoria'
from	 Production.Product p1
where	 p1.ListPrice = (
							select  MIN(p2.ListPrice)
							from	Production.Product p2
							where	p1.ProductSubcategoryID = p2.ProductSubcategoryID
						)
order by p1.ProductSubcategoryID

--verificacion
select * from Production.Product order by ProductSubcategoryID

/* SUBCONSULTAS CON EXISTS */

--55.mostrar los nombres de todos los productos presentes en la subcategoría de ruedas 

select	p.name producto
from Production.Product p
join 	Production.ProductSubcategory psc 
on p.ProductSubcategoryID = psc.ProductSubcategoryID
where psc.name like '%wheel%'

select * from Production.ProductSubcategory

--56.mostrar todos los productos que no fueron vendidos

SELECT  p.ProductID, p.Name
FROM 
    Production.Product p
WHERE  NOT EXISTS (
        SELECT 1
        FROM Sales.SalesOrderDetail sod
        WHERE sod.ProductID = p.ProductID
    )

--57. mostrar la cantidad de personas que no son vendedorres 
select count(*) 'Cantidad de personas que no son vendedores'
	from Person.Person p
	where not exists (
					select 1 
					from Sales.SalesPerson sp 
					where p.BusinessEntityID = sp.BusinessEntityID
					)

--por join 
select count(*) 'Cantidad de personas que no son vendedores'
	from Person.Person p
	left join Sales.SalesPerson sp 
	on p.BusinessEntityID = sp.BusinessEntityID
	where sp.BusinessEntityID is null 

--58.mostrar todos los vendedores (nombre y apellido) que no tengan asignado un territorio de ventas 
select p.FirstName+ ' ' + p.LastName nombres_vendedores
	from Person.Person p
	join sales.SalesPerson sp
	on sp.BusinessEntityID = p.BusinessEntityID 
where not exists (select 1 
				from  Sales.SalesTerritory st
				where  sp.TerritoryID = st.TerritoryID
				)


--por join
select p.FirstName+ ' ' + p.LastName nombres_vendedores
	from Person.Person p
	join sales.SalesPerson sp
	on sp.BusinessEntityID = p.BusinessEntityID 
	left join Sales.SalesTerritory st
	on sp.TerritoryID = st.TerritoryID
	where st.Name is null 


 /* SUBCONSULTAS CON IN   Y NOT IN   */

--59. mostrar las ordenes de venta que se hayan facturado en territorio de estado unidos unicamente 'us' 
-- por subconsulta
select * from sales.SalesOrderHeader soh
where soh.TerritoryID in (
							select st.TerritoryID
							from sales.SalesTerritory st
							where st.CountryRegionCode = 'US'
							)
-- por join 
select * from sales.SalesOrderHeader soh
join sales.SalesTerritory st
on soh.TerritoryID = st.TerritoryID
where st.CountryRegionCode = 'US' 

--60. al ejercicio anterior agregar ordenes de francia e inglaterra 
select * from sales.SalesOrderHeader soh
where soh.TerritoryID in (
							select st.TerritoryID
							from sales.SalesTerritory st
							where st.CountryRegionCode in ( 'US', 'FR' , 'GB')
							)
-- por join 
select * from sales.SalesOrderHeader soh
join sales.SalesTerritory st
on soh.TerritoryID = st.TerritoryID
where st.CountryRegionCode in ( 'US', 'FR' , 'GB')

--61.mostrar los nombres de los diez productos mas caros 
select p.name , p.ListPrice from Production.Product p
			where p.ProductID in (select top 10 pr.ProductID from [Production].Product pr order by pr.ListPrice desc)

select top 10 p.ProductID, p.name , p.ListPrice from Production.Product p
order by p.ListPrice desc

--62.mostrar aquellos productos cuya cantidad de pedidos de venta sea igual o superior a 20 

select p.name 
from Production.Product p
where p.ProductID in (select  pr.ProductID
						from Sales.SalesOrderDetail pr
						group by pr.ProductID
						having count(distinct pr.SalesOrderID) >20
						)

--63. listar el nombre y apellido de los empleados que tienen un sueldo basico de 5000 pesos. no utilizar relaciones  para su resolucion 
select p.FirstName+ ' ' + p.LastName nombres_vendedores
	from Person.Person p
	join Sales.SalesPerson sp
	on p.BusinessEntityID= sp.BusinessEntityID
	where p.BusinessEntityID in (
								select sp.BusinessEntityID
								from Sales.SalesPerson sp
								where sp.Bonus =5000
								)
 /* SUBCONSULTAS CON ALL  Y ANY  */
 
--64.mostrar los nombres de todos los productos de ruedas que fabrica adventure works cycles 
SELECT * --Name
FROM Production.Product p
JOIN purchasing.ProductVendor pv ON p.ProductID = pv.ProductID
JOIN purchasing.Vendor v ON pv.BusinessEntityID = v.BusinessEntityID
WHERE ProductSubcategoryID = ALL (
    SELECT ProductSubcategoryID
    FROM production.ProductSubcategory
    WHERE Name like '%tire%'
) AND  v.name = 'Adventure Works Cycles';

select * from purchasing.vendor where name like '%cycles%' order by name -- no hay ninguno 

--65.mostrar los clientes ubicados en un territorio no cubierto por ningún vendedor
SELECT *
FROM sales.Customer
WHERE TerritoryID <> ANY (
    SELECT TerritoryID
    FROM Sales.SalesPerson
    WHERE TerritoryID IS NOT NULL
);

--66. listar los productos cuyos precios de venta sean mayores o iguales que el precio de venta máximo de cualquier subcategoría de producto.
SELECT *
FROM production.Product
WHERE ListPrice >= ALL (
    SELECT MAX(ListPrice)
    FROM production.Product
    GROUP BY ProductSubcategoryID
);

 
 /* CONSULTAS CASE  */

----67.listar el nombre de los productos, el nombre de la subcategoria a la que pertenece junto a su categoría de precio. La categoría de precio se calcula de la siguiente manera si el precio está entre 0 y 1000 la categoría es económica.si la categoría está entre 1000 y 2000, normal  y si su valor es mayor a 2000 la categoría es cara. 

select		p.Name as Producto,
			psc.Name as Subcategoria,
			p.ListPrice as Precio,
			(case 
				when ListPrice < 1000 then 'economica'
				when ListPrice between 1000 and 2000 then 'normal'
				when ListPrice > 2000 then 'cara'
				else 'Sin categorizar'
			end) as categoria
from		Production.Product p
inner join	Production.ProductSubcategory psc
on			p.ProductSubcategoryID = psc.ProductSubcategoryID


--68.tomando el ejercicio anterior, mostrar unicamente aquellos productos cuya categoria sea "economica"
SELECT		*
FROM		(	select		p.Name as Producto,
							psc.Name as Subcategoria,
							p.ListPrice as Precio,
							(case 
								when ListPrice < 1000 then 'economica'
								when ListPrice between 1000 and 2000 then 'normal'
								when ListPrice > 2000 then 'cara'
								else 'Sin categorizar'
							end) as categoria
				from		Production.Product p
				inner join	Production.ProductSubcategory psc
				on			p.ProductSubcategoryID = psc.ProductSubcategoryID
			) as misubconsulta
WHERE		misubconsulta.categoria = 'economica'
ORDER BY	misubconsulta.Precio desc
;

-- 69:aumentar un 20% el precio de lista de todos los productos  
UPDATE	Production.Product
SET		ListPrice = ListPrice * 1.2

-- 70:aumentar un 20% el precio de lista de los productos del proveedor 1540 
UPDATE	Production.Product 
SET		ListPrice = ListPrice * 1.2
FROM	Production.Product p
INNER JOIN Purchasing.ProductVendor v ON p.ProductID = v.ProductID 
WHERE	 v.BusinessEntityID = 1540

SELECT		ListPrice as Precio
FROM		Production.Product p
INNER JOIN	Purchasing.ProductVendor v ON p.ProductID = v.ProductID 
WHERE		v.BusinessEntityID = 1540

-- 71:agregar un dia de vacaciones a los 10 empleados con mayor antiguedad.
UPDATE HumanResources.Employee
SET VacationHours = VacationHours + 24
FROM (SELECT TOP 10 BusinessEntityID FROM HumanResources.Employee
     ORDER BY HireDate ASC) AS miSubconsulta
WHERE HumanResources.Employee.BusinessEntityID = miSubconsulta.BusinessEntityID;

--verificacion
SELECT TOP 10	VacationHours,*
FROM			HumanResources.Employee e
ORDER BY		HireDate asc


-- 72: eliminar los detalles de compra (purchaseorderdetail) cuyas fechas de VENCIMIENTO PERTENEZCAN AL TERCER TRIMESTRE DEL AÑO 2006 
DELETE  
FROM Purchasing.PurchaseOrderDetail
WHERE MONTH(DueDate) between 7 and 9 and YEAR(DueDate)=2006; 


-- 73:quitar registros de la tabla salespersonquotahistory cuando las ventas del año hasta la fecha 
--almacenadas en la tabla salesperson supere el valor de 2500000

DELETE FROM Sales.SalesPersonQuotaHistory 
FROM		Sales.SalesPersonQuotaHistory AS spqh
INNER JOIN	Sales.SalesPerson AS sp
ON			spqh.BusinessEntityID = sp.BusinessEntityID
WHERE		sp.SalesYTD > 2500000.00;

/*  CONSULTAS  BULK COPY  */

--74. clonar estructura y datos de los campos nombre ,color y precio de lista de la tabla production.product en una tabla llamada productos 

select Color,Name,ListPrice
into productos
from Production.Product

--75. clonar solo estructura de los campos identificador ,nombre y apellido de la tabla person.person en una tabla llamada productos 

select LastName,MiddleName
into persona
from person.Person
where 1=1


select LastName,MiddleName
into persona2
from person.Person
where 1=0

--76.insertar un producto dentro de la tabla productos. tener en cuenta los siguientes datos. el color de producto debe ser rojo, el nombre debe ser "bicicleta mountain bike" y el precio de lista debe ser de 4000 pesos.

insert into dbo.productos (Color,Name,ListPrice) select Color,Name,ListPrice
from Production.Product
where color = 'Red' and name like 'bicicleta mountain bike' and ListPrice = 4000

--77. copiar los registros de la tabla person.person a la tabla personas cuyo identificador este entre 100 y 200
insert into dbo.persona2 
select LastName,MiddleName
from Person.person
where BusinessEntityID between 100 and 200

--78. aumentar en un 15% el precio de los pedales de bicicleta  
update [Production].[Product] set ListPrice = ListPrice*1.15
where name like '%pedal%'

select * from [Production].[Product] where name like '%pedal%'

--79. eliminar de las personas cuyo nombre empiecen con la letra m
delete from dbo.persona where LastName like 'm%'

--80. borrar todo el contenido de la tabla productos
truncate table dbo.productos

--81. borrar todo el contenido de la tabla personas sin utilizar la instrucción delete.
truncate table dbo.persona


/* PROCEDIMIENTOS ALMACENADOS  */
--82. crear un procedimiento almacenado que dada una determinada inicial ,devuelva codigo, nombre,apellido y direccion de correo de los empleados cuyo nombre coincida con la inicial ingresada
--83. crear un procedimiento almacenado que devuelva los productos que lleven de fabricado la cantidad de dias que le pasemos como parametro
--84. crear un procedimiento almacenado que permita actualizar y ver los precios de un determinado producto que reciba como parametro
--85. armar un procedimineto almacenado que devuelva los proveedores que proporcionan el producto especificado por parametro. 
--86. crear un procedimiento almacenado que devuelva nombre,apellido y sector del empleado que le pasemos como argumento.no es necesario pasar el nombre y apellido exactos al procedimiento.

/*  FUNCIONES ESCALARES */

--87.armar una funcion que devuelva los productos que estan por encima del promedio de precios general
SELECT *
FROM Production.Product
WHERE ListPrice > (SELECT avg(ListPrice) FROM Production.Product)

CREATE FUNCTION promedio()
returns money
as
BEGIN
		declare @promedio money
		select @promedio=avg(ListPrice) FROM Production.Product
		return @promedio
END

select * from Production.Product where ListPrice > dbo.promedio()

--88.armar una función que dado un código de producto devuelva el total de ventas para dicho producto. luego, mediante una consulta, traer codigo, nombre y total de ventas ordenados por esta ultima columna
select sum(LineTotal) from [Sales].[SalesOrderDetail] where ProductID = 778

CREATE FUNCTION f_venta_total(@codigo int)
returns numeric(38,6)
as
BEGIN

		declare @total numeric(38,6)
		select @total=sum(LineTotal) from [Sales].[SalesOrderDetail] where ProductID = @codigo
		return @total
END

select a.ProductID,a.Name, dbo.f_venta_total(a.ProductID) from Production.Product a
order by 3 desc

/* funciones de tabla en linea devuelve una tabla, 
*/ 

--89.armar una función que dado un año , devuelva nombre y  apellido de los empleados que ingresaron ese año 
create FUNCTION historico_empleados(@year int)
returns table
as
	return (SELECT		FirstName , LastName
			FROM		[HumanResources].[Employee] e
			inner join [Person].[Person] p on e.BusinessEntityID = p.BusinessEntityID
			WHERE		year(e.HireDate) = @year)

select * from historico_empleados(2003)

select year(hiredate),count(*) from [HumanResources].[Employee]
group by year(hiredate)

--90.armar una función que dado el codigo de negocio cliente de la fabrica, devuelva el codigo, nombre y las ventas del año hasta la fecha para cada producto vendido en el negocio ordenadas por esta ultima columna. 



/*funciones de multisentencia devuelve variables de tipo de tabla
*/
--91. crear una  función llmada "ofertas" que reciba un parámetro correspondiente a un precio y nos retorne una tabla con código,nombre, color y precio de todos los productos cuyo precio sea inferior al parámetro ingresado

/*datetime
*/ 

--92. mostrar la cantidad de horas que transcurrieron desde el comienzo del año
--93. mostrar la cantidad de dias transcurridos entre la primer y la ultima venta 
