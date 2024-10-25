/*Ejercicio sobre triggers

Crea una base de datos llamada testDisparador que contenga una tabla llamada alumnos con las siguientes columnas.

create database testDisparador
Crea una base de datos llamada testDisparador que contenga una tabla llamada alumnos con las siguientes columnas.
Tabla alumnos:
id (entero sin signo)
nombre (cadena de caracteres)
apellido (cadena de caracteres)
nota (número real)*/


CREATE TABLE alumnos (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    nota FLOAT
);

--Una vez creada la tabla escriba dos triggers con las siguientes características:

/*Trigger 1: trigger_check_nota_before_insert
Se ejecuta sobre la tabla alumnos.
Se ejecuta antes de una operación de inserción.
Si el nuevo valor de la nota que se quiere insertar es negativo, se guarda como 0.
Si el nuevo valor de la nota que se quiere insertar es mayor que 10, se guarda como 10.*/;
go
-- Trigger 1: trigger_check_nota_before_insert
CREATE TRIGGER trigger_check_nota
ON alumnos before INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar y ajustar el valor de la nota antes de la inserción
    IF EXISTS (SELECT 1 FROM inserted WHERE nota < 0)
    BEGIN
        UPDATE inserted SET nota = 0 WHERE nota < 0;
    END;

    IF EXISTS (SELECT 1 FROM inserted WHERE nota > 10)
    BEGIN
        UPDATE inserted SET nota = 10 WHERE nota > 10;
    END;
END;
GO


/*Trigger2 : trigger_check_nota_before_update
Se ejecuta sobre la tabla alumnos.
Se ejecuta antes de una operación de actualización.
Si el nuevo valor de la nota que se quiere actualizar es negativo, se guarda como 0.
Si el nuevo valor de la nota que se quiere actualizar es mayor que 10, se guarda como 10.
Una vez creados los triggers escriba 3 sentencias de inserción y actualización sobre la tabla alumnos y verifica que los triggers se están ejecutando correctamente.*/

-- Trigger 2: trigger_check_nota_before_update
CREATE OR ALTER TRIGGER trigger_check_nota_before_update
ON alumnos
BEFORE UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar y ajustar el valor de la nota antes de la actualización
    IF EXISTS (SELECT 1 FROM inserted WHERE nota < 0)
    BEGIN
        UPDATE inserted SET nota = 0 WHERE nota < 0;
    END;

    IF EXISTS (SELECT 1 FROM inserted WHERE nota > 10)
    BEGIN
        UPDATE inserted SET nota = 10 WHERE nota > 10;
    END;
END;
GO
