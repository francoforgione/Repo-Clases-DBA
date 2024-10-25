-- Script de funciones y procedimientos almacenados
use TRABAJO_FINAL;
-- 1. Función calcular_total_ventas
DELIMITER //

CREATE FUNCTION calcular_total_ventas(mes INT, anio INT) 
RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total DECIMAL(10, 2);

    SELECT SUM(monto) INTO total
    FROM Ventas
    WHERE MONTH(fecha) = mes AND YEAR(fecha) = anio;

    RETURN COALESCE(total, 0);
END //

DELIMITER ;

-- Ejemplo de uso
SELECT calcular_total_ventas(1, 2023) AS total_ventas_enero;

select * from Ventas;


-- 2. Función obtener_nombre_empleado
DELIMITER //

CREATE FUNCTION obtener_nombre_empleado(id_empleado INT)
RETURNS VARCHAR(200)
BEGIN
    DECLARE nombre_completo VARCHAR(200);

    SELECT CONCAT(nombre, ' ', apellido) INTO nombre_completo
    FROM Empleados
    WHERE id = id_empleado;

    RETURN nombre_completo;
END //

DELIMITER ;

-- Ejemplo de uso
SELECT obtener_nombre_empleado(1) AS nombre_empleado;


-- 3. Procedimiento almacenado obtener_promedio
DELIMITER //

CREATE PROCEDURE obtener_promedio(nombre_curso VARCHAR(100))
BEGIN
    DECLARE prom DECIMAL(5, 2);

    SELECT AVG(calificacion) INTO prom
    FROM Inscripciones
    WHERE curso = nombre_curso;

    SELECT prom AS promedio;
END //

DELIMITER ;

-- Ejemplo de uso
CALL obtener_promedio('Matemáticas');

-- 4. Procedimiento almacenado actualizar_stock
DELIMITER //

CREATE PROCEDURE actualizar_stock(codigo_producto INT, cantidad INT)
BEGIN
    DECLARE stock_actual INT;

    SELECT stock INTO stock_actual
    FROM Productos
    WHERE codigo = codigo_producto;

    IF stock_actual IS NOT NULL THEN
        UPDATE Productos
        SET stock = stock + cantidad
        WHERE codigo = codigo_producto;
    END IF;
END //

DELIMITER ;

-- Ejemplo de uso
CALL actualizar_stock(101, 20);

select * from productos

-- 5 . Creación de la vista
CREATE VIEW LibrosDeCocina AS
SELECT title, authors.au_fname AS autor, price, publishers.pub_name AS editorial
FROM titles
JOIN titleauthor ON titles.title_id = titleauthor.title_id
JOIN authors ON titleauthor.au_id = authors.au_id
JOIN publishers ON titles.pub_id = publishers.pub_id
WHERE type = 'cookbook';

-- 6. 

CREATE TABLE fabricantes (
    id_fabricante INT PRIMARY KEY,
    nombre_fabricante VARCHAR(255) NOT NULL
);

INSERT INTO fabricantes (id_fabricante, nombre_fabricante)
VALUES(1, 'Fabricante A'),(2, 'Fabricante B'),(3, 'Fabricante C');


CREATE TABLE productos (
    id_producto INT PRIMARY KEY,
    id_fabricante INT,
    nombre_producto VARCHAR(255) NOT NULL,
    fecha_lanzamiento DATE,
    FOREIGN KEY (id_fabricante) REFERENCES fabricantes(id_fabricante)
);

INSERT INTO productos (id_producto, id_fabricante, nombre_producto, fecha_lanzamiento)
VALUES(1, 1, 'Producto X', '2020-01-01'),(2, 2, 'Producto Y', '2019-12-01'), (3, 3, 'Producto Z', '2021-05-15'); 

-- a) 
CREATE INDEX idx_productos_id_fabricante_nombre ON productos (id_fabricante, nombre_producto);
-- b) 
CREATE UNIQUE INDEX idx_productos_id_producto ON productos (id_producto);
-- c) -- no se puede dropear por la integridad referncial 

-- d) 
CREATE UNIQUE INDEX idx_productos_id_fabricante_unique ON productos (id_fabricante);
-- e) 

CREATE INDEX idx_productos_id_fabricante ON productos (id_fabricante);
DROP INDEX idx_productos_id_fabricante ON productos;


-- 7
CREATE TABLE empleados (
  nombre VARCHAR(50) NOT NULL,
  edad INT NOT NULL,
  antiguedad INT NOT NULL
);


CREATE TABLE jubilados (
  nombre VARCHAR(50) NOT NULL,
  edad INT NOT NULL,
  antiguedad INT NOT NULL
);

DELIMITER // 
CREATE TRIGGER trg_after_insert_or_update_empleados
AFTER INSERT OR UPDATE ON empleados
FOR EACH ROW
BEGIN
    -- Lógica para insertar o actualizar en jubilados si cumple con los criterios
    IF NEW.antiguedad >= 30 AND NEW.edad >= 65 THEN
        INSERT INTO jubilados (nombre, edad, antiguedad)
        VALUES (NEW.nombre, NEW.edad, NEW.antiguedad)
        ON DUPLICATE KEY UPDATE edad = NEW.edad, antiguedad = NEW.antiguedad;
    ELSE
        -- Eliminar de jubilados si la actualización ya no cumple con los criterios
        DELETE FROM jubilados WHERE nombre = NEW.nombre;
    END IF;
END;
DELIMITER ;

select * from empleados;

select * from jubilados ;


-- 8 

use  trabajo_final_2;
-- Crear la tabla de empleados (si no existe)
CREATE TABLE IF NOT EXISTS empleados (
    codigo_empleado VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(50),
    salario DECIMAL(10, 2)
);

-- Insertar datos en la tabla empleados
INSERT INTO empleados (codigo_empleado, nombre, salario) VALUES
('E001', 'Juan Perez', 3000.00),
('E002', 'Maria Garcia', 4500.00),
('E003', 'Carlos Sanchez', 5000.00);

-- Crear el procedimiento almacenado
DELIMITER //

CREATE PROCEDURE ActualizarEmpleados (
    IN codigo_empleado VARCHAR(10),
    IN salario_actualizado DECIMAL(10, 2)
)
BEGIN
    DECLARE salario_actual DECIMAL(10, 2);
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Obtener el salario actual del empleado
    SELECT salario INTO salario_actual 
    FROM empleados 
    WHERE codigo_empleado = codigo_empleado;

    -- Verificar si el nuevo salario es válido
    IF salario_actualiza
    do >= salario_actual THEN
        -- Actualizar el salario del empleado
        UPDATE empleados 
        SET salario = salario_actualizado 
        WHERE codigo_empleado = codigo_empleado;
        COMMIT;
    ELSE
        -- Mostrar mensaje y realizar rollback
        SELECT 'El nuevo salario no puede ser menor que el salario actual. Operación cancelada.' AS mensaje;
        ROLLBACK;
    END IF;
END //

DELIMITER ;

select * from empleados;

-- Llamar al procedimiento almacenado
-- Caso 1: salario actualizado es mayor al salario actual
CALL ActualizarEmpleados('E001', 3500.00);

-- Caso 2: salario actualizado es igual al salario actual
CALL ActualizarEmpleados('E002', 4500.00);

-- Caso 3: salario actualizado es menor al salario actual
CALL ActualizarEmpleados('E003', 4500.00);

-- Verificar la tabla de empleados
SELECT * FROM empleados;

-- 9
-- a
CREATE USER 'usuario_sin_privilegios'@'localhost' IDENTIFIED BY 'password123';
-- b
CREATE USER 'usuario_lectura'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT ON pubs.* TO 'usuario_lectura'@'localhost';
-- c
CREATE USER 'usuario_escritura'@'localhost' IDENTIFIED BY 'password123';
GRANT INSERT, UPDATE, DELETE ON pubs.* TO 'usuario_escritura'@'localhost';
-- d 
CREATE USER 'usuario_todos_privilegios'@'localhost' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON pubs.* TO 'usuario_todos_privilegios'@'localhost';
-- e
CREATE USER 'usuario_lectura_titles'@'localhost' IDENTIFIED BY 'password123';
GRANT SELECT ON pubs.titles TO 'usuario_lectura_titles'@'localhost';
-- f 
DROP USER 'usuario_todos_privilegios'@'localhost';
-- g 
DROP USER 'usuario_lectura'@'localhost', 'usuario_escritura'@'localhost';
-- h 
-- Revocar privilegios
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'usuario_lectura_titles'@'localhost';
-- Eliminar usuario
DROP USER 'usuario_lectura_titles'@'localhost';
-- i 
SHOW GRANTS FOR 'usuario_escritura'@'localhost';










