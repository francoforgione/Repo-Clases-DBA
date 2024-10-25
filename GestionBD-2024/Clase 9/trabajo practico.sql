-- EJERCICIO 1

CREATE TABLE cuentas (
    numero_cuenta VARCHAR (10) PRIMARY KEY,
    saldo DECIMAL (10, 2)
);

INSERT INTO cuentas (numero_cuenta, saldo) VALUES
    ('A', 1000.00),
    ('B', 750.00),
    ('C', 1200.00),
    ('D', 500.00),
    ('E', 2000.00);

begin;
UPDATE cuentas 
SET saldo = 
    CASE 
        WHEN numero_cuenta = 'A' THEN saldo - 100 
        WHEN numero_cuenta = 'B' THEN saldo + 100 
        ELSE saldo 
    END
WHERE numero_cuenta IN ('A', 'B');

commit;

-- EJERCICIO 2

-- Crea un procedimiento almacenado llamado ActualizarInventario que tome dos parámetros de entrada: 
-- producto_id (VARCHAR, 10): El identificador del producto a actualizar.
-- cantidad_a_restar (INT): La cantidad que se restará del inventario.

-- En el procedimiento, utiliza una transacción para realizar la actualización del inventario:

-- Obtene la cantidad actual del producto especificado.
-- Verifica si la cantidad restada sería válida (mayor o igual a cero).
-- Si la cantidad es válida, realiza la actualización del inventario restando la cantidad especificada.
-- Si la cantidad restada sería negativa, muestra un mensaje al usuario indicando que la operación se cancela y realiza un rollback.

-- Llama al procedimiento ActualizarInventario con diferentes valores de producto_id y cantidad_a_restar, incluyendo casos donde la cantidad restada resultaría en un inventario negativo.

-- Verifica que el procedimiento funcione correctamente y que se muestren mensajes de error y se realice un rollback cuando corresponda.


-- Actualización de cantidades de productos en el inventario
CREATE TABLE inventario (
    producto_id VARCHAR (10) PRIMARY KEY,
    cantidad INT
);

INSERT INTO inventario (producto_id, cantidad) VALUES
    ('Producto1', 50),
    ('Producto2', 30),
    ('Producto3', 70),
    ('Producto4', 20),
    ('Producto5', 60);

DELIMITER //
CREATE PROCEDURE ActualizarInventario (
    IN p_producto_id VARCHAR (10),
    IN cantidad_a_restar INT
)
BEGIN
    DECLARE nueva_cantidad INT;

    START TRANSACTION;

    -- Obtene la cantidad actual del producto
    SELECT cantidad INTO nueva_cantidad FROM inventario WHERE producto_id = p_producto_id;

    -- Verifica si la cantidad restada es válida
    IF nueva_cantidad - cantidad_a_restar >= 0 THEN
        -- Realiza la actualización del inventario
        UPDATE inventario SET cantidad = nueva_cantidad - cantidad_a_restar WHERE producto_id = p_producto_id;
        COMMIT;
    ELSE
        -- La cantidad restada sería negativa, muestra un mensaje y realiza un rollback

        select 'La cantidad restada resultaría en un inventario negativo. Operación cancelada.';
        ROLLBACK;
    END IF;
END;
//
DELIMITER ;

CALL ActualizarInventario('Producto1', 15);
CALL ActualizarInventario('Producto1', 1500);

-- EJERCICIO 3 

CREATE TABLE cuentas_clientes (
    numero_cuenta VARCHAR (10) PRIMARY KEY,
    saldo DECIMAL (10, 2)
);

INSERT INTO cuentas_clientes (numero_cuenta, saldo) VALUES
    ('Cuenta1', 1000.00),
    ('Cuenta2', 750.00),
    ('Cuenta3', 1200.00),
    ('Cuenta4', 500.00),
    ('Cuenta5', 2000.00);

CREATE TABLE transacciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_cuenta VARCHAR (10),
    monto DECIMAL (10, 2)
);

ALTER TABLE transacciones
ADD COLUMN RESULTADO VARCHAR(25);

select * from cuentas_clientes;

DELIMITER //

CREATE OR REPLACE PROCEDURE RegistrarCompra(
    IN p_cuenta VARCHAR(10),
    IN p_monto DECIMAL(10, 2)
)
BEGIN
    DECLARE saldo_actual DECIMAL(10, 2);
    
    START TRANSACTION;
    
    -- Obtener el saldo actual de la cuenta
    SELECT saldo INTO saldo_actual FROM cuentas_clientes WHERE numero_cuenta = p_cuenta;
    
    -- Verificar si el saldo es suficiente para la compra
    IF saldo_actual >= p_monto THEN
        -- Restar el monto de la compra del saldo
        UPDATE cuentas_clientes SET saldo = saldo - p_monto WHERE numero_cuenta = p_cuenta;
        
        -- Registrar la transacción
        INSERT INTO transacciones (numero_cuenta, monto, RESULTADO) VALUES (p_cuenta, p_monto, 'TRANSACCION EXITOSA');
        
        COMMIT;
        
        SELECT 'Compra registrada exitosamente.' AS mensaje;
    ELSE
        -- Mostrar mensaje de error y realizar MSJ BORRADO 
        INSERT INTO transacciones (numero_cuenta, monto,RESULTADO) VALUES (p_cuenta, p_monto,'TRANSACCION FALLIDA');
        
        SELECT 'Error: Saldo insuficiente. La compra se cancela.' AS mensaje;
    END IF;
END //

DELIMITER ;



SELECT * FROM TRANSACCIONES; 

CALL RegistrarCompra('Cuenta1', 500.00);
CALL RegistrarCompra('Cuenta2', 1000.00);
CALL RegistrarCompra('Cuenta3', 1500.00);
CALL RegistrarCompra('Cuenta4', -700.00);
CALL RegistrarCompra('Cuenta5', 2000.00);
