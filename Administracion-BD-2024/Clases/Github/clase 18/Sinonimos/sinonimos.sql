-- Los sinónimos se pueden crear utilizando la instrucción CREATE SYNONYM de SQL Server. La sintaxis básica es la siguiente:


-- CREATE SYNONYM [nombre_sinonimo]
-- FOR [objeto_base_de_datos]
-- [([esquema])];

-- Recomendaciones para el uso de sinónimos:

-- Utilice sinónimos para nombres de objetos largos o complejos.
-- Utilice sinónimos para crear nombres de objetos más descriptivos.
-- Utilice sinónimos para ocultar la complejidad de la estructura de la base de datos a los usuarios.

CREATE SYNONYM miTablaClientes
FOR Sales.Customer

SELECT * FROM dbo.miTablaClientes

-- En este ejemplo, la consulta selecciona todas las filas de la tabla Production.Customers (a la que se hace referencia mediante el sinónimo mi_tabla_clientes).


DROP SYNONYM [miTablaClientes]


