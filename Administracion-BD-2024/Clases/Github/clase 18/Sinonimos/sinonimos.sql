-- Los sin�nimos se pueden crear utilizando la instrucci�n CREATE SYNONYM de SQL Server. La sintaxis b�sica es la siguiente:


-- CREATE SYNONYM [nombre_sinonimo]
-- FOR [objeto_base_de_datos]
-- [([esquema])];

-- Recomendaciones para el uso de sin�nimos:

-- Utilice sin�nimos para nombres de objetos largos o complejos.
-- Utilice sin�nimos para crear nombres de objetos m�s descriptivos.
-- Utilice sin�nimos para ocultar la complejidad de la estructura de la base de datos a los usuarios.

CREATE SYNONYM miTablaClientes
FOR Sales.Customer

SELECT * FROM dbo.miTablaClientes

-- En este ejemplo, la consulta selecciona todas las filas de la tabla Production.Customers (a la que se hace referencia mediante el sin�nimo mi_tabla_clientes).


DROP SYNONYM [miTablaClientes]


