/*Trabajo Práctico Diseño de Base de Datos 
A partir de la siguiente especificación, un Analista deberá recolectar datos para poder diseñar una Base de Datos. 

Esta empresa se encuentra ubicada en Tierra del Fuego y se dedica al armado de televisores. 

Las componentes de los televisores pueden ser comprados a un importador, en tal caso la compra viene acompañada de la factura, otras piezas son fabricadas en la empresa, para lo cual esas piezas tienen asignado un operario que se dedica exclusivamente a un tipo de pieza, aunque una pieza puede ser fabricada por más de un operario, el operario completa una hoja de confección con las la fecha y la cantidad fabricada. 

Los diferentes modelos de televisores están compuestos por 300 o más piezas, aunque una pieza puede estar incorporada en más de un televisor, existe un mapa de armado para cada modelo de televisor donde se indica la ubicación y el orden de las piezas que lo componen. 
 */

a) Determinar las entidades relevantes al Sistema. 
 --compras
 --proveedores
 --articulos_proveedor(componentes)
 --produccion
 --empleados
 --piezas_terminadas(stock)
 --modelos_televisor
 --tipo_produccion

b) Determinar los atributos de cada entidad. 
--proveedor
	--proveedor_id
	--pais
	--nombre
--compras
	--numero_orden_compra
	--fecha_compra
	--fecha_recepcion
	--articulo
	--precio
	--cantidad
	--impuestos
--articulo_proveedor 
	--descripcion
	--articulo_id
	--proveedor_id
	--precio
	--estado (delete, active)
	--instrucciones
--piezas_terminadas(stock)
	--numero_articulo
	--descripcion
	--cantidad_disponible
	--cantidad_en_roduccion
	--fecha
--produccion
	--id_transaccion
	--cantidad
	--descripcion
	--cantidad
	--usuario
	--fecha_inicio
	--fecha_fin
	--tipo_produccion(produccion de componentes o produccion de piezas finales)
--tipo_produccion
	--codigo
	--descripcion
--modelos_televisor
	--articulo_id
	--descripcion
	--instrucciones
--empleados
	--empleado_id
	--nombre
	--apellido
	--usuario

c) Confeccionar el Diagrama de Entidad Relación (DER), junto al Diccionario de Datos 


d) Realizar el Diagrama de Tablas e implementar en código SQL la Base de Datos. 

 -- Tabla para los proveedores

CREATE TABLE Proveedores (
    proveedor_id INT PRIMARY KEY,
    pais VARCHAR(100),
    nombre VARCHAR(255),
    direccion VARCHAR(100),
    telefono VARCHAR(20)
);

-- tabla para las compras
CREATE TABLE Compras (
    numero_orden_compra INT PRIMARY KEY,
    proveedor_id INT,
    fecha_compra DATE,
    fecha_recepcion DATE,
    articulo_id INT,
    precio DECIMAL(10, 2),
    cantidad INT,
    impuestos DECIMAL(10, 2),
    CONSTRAINT FK_Compras_Proveedor_Articulo 
        FOREIGN KEY (articulo_id, proveedor_id) 
        REFERENCES ArticuloProveedor(articulo_id, proveedor_id)
);


-- Tabla para la relación entre artículo y proveedor
CREATE TABLE ArticuloProveedor (
    articulo_id INT,
    proveedor_id INT,
    descripcion VARCHAR(255),
    precio DECIMAL(10, 2),
    estado VARCHAR(10),
    instrucciones VARCHAR(255),
    CONSTRAINT PK_ArticuloProveedor PRIMARY KEY (articulo_id, proveedor_id), -- Clave primaria compuesta
    CONSTRAINT FK_ArticuloProveedor_Articulo FOREIGN KEY (articulo_id) REFERENCES PiezasTerminadas(numero_articulo),
    CONSTRAINT FK_ArticuloProveedor_Proveedor FOREIGN KEY (proveedor_id) REFERENCES Proveedores(proveedor_id)
);

-- Tabla para las piezas terminadas (stock)
CREATE TABLE PiezasTerminadas (
    numero_articulo INT PRIMARY KEY,
    descripcion VARCHAR(255),
    cantidad_disponible INT,
    cantidad_en_produccion INT,
    fecha DATE,
    modelo_televisor_id INT,
    CONSTRAINT FK_PiezasTerminadas_ModelosTelevisor FOREIGN KEY (modelo_televisor_id) REFERENCES ModelosTelevisor(articulo_id)
);

-- Tabla para la producción
CREATE TABLE Produccion (
    id_transaccion INT PRIMARY KEY,
    cantidad INT,
    descripcion VARCHAR(255),
    usuario VARCHAR(100), 
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    tipo_produccion_id INT,
	numero_orden_compra INT, -- Esta columna se utilizará para relacionar con la tabla Compras
	CONSTRAINT FK_Produccion_TipoProduccion FOREIGN KEY (tipo_produccion_id) REFERENCES TipoProduccion(tipo_produccion_id),
    CONSTRAINT FK_Produccion_Empleados FOREIGN KEY (usuario) REFERENCES Empleados(usuario),
	CONSTRAINT FK_Produccion_Compras FOREIGN KEY (numero_orden_compra) REFERENCES Compras(numero_orden_compra)
);



-- Tabla para los tipos de producción
CREATE TABLE TipoProduccion (
    tipo_produccion_id INT PRIMARY KEY,
    descripcion VARCHAR(255)
);



-- Tabla para los modelos de televisores
CREATE TABLE ModelosTelevisor (
    articulo_id INT PRIMARY KEY,
    descripcion VARCHAR(255),
    instrucciones VARCHAR(255)
);

-- Tabla para los empleados
CREATE TABLE Empleados (
    empleado_id INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    usuario VARCHAR(100) UNIQUE
);



e) Crear al menos 2 consultas relacionadas para poder probar la Base de Datos. 


SELECT c.numero_orden_compra, c.fecha_compra, c.articulo_id, c.cantidad AS cantidad_comprada, p.id_transaccion, p.descripcion AS descripcion_produccion, p.cantidad AS cantidad_producida
FROM Compras c
INNER JOIN Produccion p ON c.numero_orden_compra = p.numero_orden_compra;


SELECT p.nombre AS nombre_proveedor, c.numero_orden_compra, c.fecha_compra, c.articulo_id, c.cantidad, c.precio
FROM Proveedores p
INNER JOIN Compras c ON p.proveedor_id = c.proveedor_id;

