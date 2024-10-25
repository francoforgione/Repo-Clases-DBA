/*EJERCICIO 1 */

CREATE FUNCTION EmpleadosContratados(@Year INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT 
        p.FirstName, 
        p.LastName
    FROM 
        HumanResources.Employee e
    INNER JOIN 
        Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
    WHERE  
        YEAR(e.HireDate) = @Year
);

select * from EmpleadosContratados(2005)


/*EJERCICIO 2*/


CREATE PROCEDURE dbo.ActualizarPrecio
    @ProductID INT,      
    @NewPrice DECIMAL(19,4) 
AS
BEGIN
    
    UPDATE Production.Product
    SET ListPrice = @NewPrice
    WHERE ProductID = @ProductID;
    
    SELECT 
        ProductID,
        Name,
        ListPrice AS UpdatedPrice
    FROM 
        Production.Product
    WHERE 
        ProductID = @ProductID;
END;

EXEC dbo.ActualizarPrecio @ProductID = 707, @NewPrice = 199.99;

/*EJERCICIO 3 */

DECLARE @Promedio DECIMAL(18, 2);
SELECT @Promedio = AVG(ListPrice)
FROM Production.Product

BEGIN TRANSACTION;

UPDATE Production.Product
SET ListPrice = ListPrice * 1.15;

IF @Promedio <= (SELECT MIN(ListPrice) FROM Production.Product WHERE ListPrice > 0)
BEGIN
    -- Revertir la operación si el promedio no supera el precio mínimo
    ROLLBACK TRANSACTION;
    PRINT 'El promedio no supera el precio mínimo. Operación revertida.';
END
ELSE
BEGIN
    -- Confirmar la operación si el promedio supera el precio mínimo
    COMMIT TRANSACTION;
    PRINT 'Operación completada exitosamente.';
END

/*EJERCICIO 4 */

--datos de prueba 
CREATE TABLE secciones (
    seccion_id INT PRIMARY KEY,
    sueldo_maximo DECIMAL(18, 2)
);

CREATE TABLE empleados (
    empleado_id INT PRIMARY KEY,
    nombre NVARCHAR(100),
    seccion_id INT,
    sueldo DECIMAL(18, 2),
    FOREIGN KEY (seccion_id) REFERENCES secciones(seccion_id)
);

--trigger 
CREATE TRIGGER trigger_sueldo_empleado
ON empleados
AFTER INSERT
AS
BEGIN
    
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN secciones s ON i.seccion_id = s.seccion_id
        WHERE i.sueldo > s.sueldo_maximo
    )
    BEGIN
        RAISERROR ('Uno o más empleados tienen sueldos mayores que el sueldo máximo permitido para su sección.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;


--insert de prueba
INSERT INTO secciones (seccion_id, sueldo_maximo)
VALUES (1, 5000), (2, 7000);

INSERT INTO empleados (empleado_id, nombre, seccion_id, sueldo)
VALUES (1, 'Juan Pérez', 1, 6000);

/*EJERCICIO 5 */

BEGIN TRY
  
    BEGIN TRANSACTION;
	DECLARE @Resultado INT;
	
	SET @Resultado =  10 / 0;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    -- Atrapar el error y mostrar mensaje
    PRINT 'Error: ' + ERROR_MESSAGE();

    -- Revertir la transacción
    ROLLBACK TRANSACTION;
END CATCH;


/*EJERCICIO 6 */

CREATE DATABASE Datos
ON 
(
    NAME = N'Dato_a',
    FILENAME = N'C:\DATA\Dato_a.mdf',  
    SIZE = 2048KB,
    FILEGROWTH = 1024KB
)
LOG ON 
(
    NAME = N'Datos_log',
    FILENAME = N'C:\DATA\Datos_log.ldf',  
    SIZE = 1024KB,
    FILEGROWTH = 1024KB
);


/*EJERCICIO 7 */

CREATE DATABASE BaseL2
ON 
PRIMARY 
(
    NAME = N'BaseL2_a',
    FILENAME = N'C:\DATA\BaseL2_a.mdf',  
    SIZE = 4096KB,
    FILEGROWTH = 1024KB
),
FILEGROUP SECONDARY
(
    NAME = N'BaseL2_b',
    FILENAME = N'C:\DATA\BaseL2_b.sdf',  
    SIZE = 2048KB,
    FILEGROWTH = 1024KB
)
LOG ON 
(
    NAME = N'BaseL2_log',
    FILENAME = N'C:\DATA\BaseL2_log.ldf',  
    SIZE = 1024KB,
    FILEGROWTH = 1024KB
);

/*EJERCICIO 8 */

CREATE TABLE LIBROS (
    COD_LIBRO INT PRIMARY KEY,
    TITULO VARCHAR(100),
    AUTOR VARCHAR(100),
    EDITORIAL VARCHAR(100)
);

CREATE TABLE LECTORES (
    COD_LECTOR INT PRIMARY KEY,
    NOMBRE_LECTOR VARCHAR(100),
    TEL_LECTOR VARCHAR(20)
);

CREATE TABLE PRESTAMOS (
    COD_PRESTAMO INT PRIMARY KEY,
    COD_LIBRO INT,
    COD_LECTOR INT,
    FECHA_PRESTAMO DATE,
    FECHA_DEV DATE,
    FOREIGN KEY (COD_LIBRO) REFERENCES LIBROS(COD_LIBRO),
    FOREIGN KEY (COD_LECTOR) REFERENCES LECTORES(COD_LECTOR)
);

/*EJERCICIO 9 */ 
ALTER DATABASE BaseL2 ADD FILEGROUP fg_M;
ALTER DATABASE BaseL2 ADD FILEGROUP fg_F;
GO

-- Añadir archivos a los grupos de archivos
ALTER DATABASE BaseL2 ADD FILE 
(
    NAME = 'Archivo_fg_M',
    FILENAME = 'C:\DATA\Archivo_fg_M.ndf'
) 
TO FILEGROUP fg_M;

ALTER DATABASE BaseL2 ADD FILE 
(
    NAME = 'Archivo_fg_F',
    FILENAME = 'C:\DATA\Archivo_fg_F.ndf'
) 
TO FILEGROUP fg_F;
GO

-- Crear la función de partición para sexo
CREATE PARTITION FUNCTION pf_Sexo (CHAR(1))
AS RANGE LEFT FOR VALUES ('F');
GO

-- Crear el esquema de partición
CREATE PARTITION SCHEME ps_Sexo
AS PARTITION pf_Sexo
TO (fg_F, fg_M);
GO

-- Crear la tabla personas
CREATE TABLE personas (
    nombre NVARCHAR(100),
    sexo CHAR(1)
) ON ps_Sexo(sexo);
GO


INSERT INTO personas (nombre, sexo) VALUES ('Alicia', 'F');
INSERT INTO personas (nombre, sexo) VALUES ('Franco', 'M');
INSERT INTO personas (nombre, sexo) VALUES ('Emilia', 'F');
INSERT INTO personas (nombre, sexo) VALUES ('Max', 'M');
GO

SELECT 
    nombre, 
    sexo, 
    $PARTITION.pf_Sexo(sexo) AS PartitionNumber
FROM personas;
GO
/*EJERCICIO 10 */
--a)
CREATE LOGIN ventas WITH PASSWORD=N'ventas1234',
DEFAULT_DATABASE=pubs, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
--b) c) 
CREATE USER juan_perez
FOR LOGIN ventas WITH DEFAULT_SCHEMA=[dbo]

--d)
GRANT SELECT, INSERT, UPDATE 
ON sales 
TO juan_perez;
--e) 
revoke select,insert,update on sales to juan_perez

Grant select (codigo, nombre) on sales to juan_perez



/*EJERCICIO 11 */
--f)

/*EJERCICIO 12 */
--d) 

/*EJERCICIO 13 */
--f)

/*EJERCICIO 14 */
--a) 