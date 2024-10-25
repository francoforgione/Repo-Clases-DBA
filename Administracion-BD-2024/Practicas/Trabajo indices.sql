EJERCITACIÓN

/*1-Crear una tabla llamada alumnos con los siguientes campos:
  
  legajo: char(5) not null
  documento: char(8) not null
  apellido: varchar(30)
  nombre: varchar(30)
  nota: decimal(4,2)
 */

 CREATE TABLE alumnos (
    legajo CHAR(5) NOT NULL,
    documento CHAR(8) NOT NULL,
    apellido VARCHAR(30),
    nombre VARCHAR(30),
    nota DECIMAL(4, 2),
    PRIMARY KEY (legajo)
);


--2-Ingresar 6 registros con, al menos, 2 registros con igual apellido.
INSERT INTO alumnos (legajo, documento, apellido, nombre, nota) 
VALUES
    ('001', '12345678', 'Gómez', 'Juan', 8.5),
    ('002', '23456789', 'Pérez', 'María', 7.2),
    ('003', '34567890', 'González', 'Pedro', 6.8),
    ('004', '45678901', 'Gómez', 'Laura', 9.0),
    ('005', '56789012', 'Sánchez', 'Ana', 7.5),
    ('006', '67890123', 'Martínez', 'Carlos', 8.2);



--3-Intente crear un índice agrupado único para el campo "apellido".
CREATE UNIQUE CLUSTERED INDEX IX_Apellido ON alumnos (apellido);

--si se quiere crear un indice agrupado por apellido y nombre ya que ya esta creado 
--CREATE UNIQUE CLUSTERED INDEX IX_ApellidoNombre ON alumnos (apellido, nombre);

--4-Cree un índice agrupado, no único, para el campo "apellido".
ALTER TABLE alumnos
DROP CONSTRAINT PK__alumnos__818C9F868CC16C47;

CREATE CLUSTERED INDEX IX_Apellido ON alumnos (apellido);

--5-Intente establecer una restricción "primary key" al campo "legajo" especificando que cree un índice agrupado.
DROP INDEX IX_Apellido ON alumnos;

ALTER TABLE alumnos
ADD CONSTRAINT PK_Legajo PRIMARY KEY CLUSTERED (legajo);

--6-Establezca la restricción "primary key" al campo "legajo" especificando que cree un índice no agrupado.
alter table alumnos 
drop constraint PK_Legajo;

ALTER TABLE alumnos
ADD CONSTRAINT PK_Legajo PRIMARY KEY NONCLUSTERED (legajo);


--7-Vea los índices y las restricciones de la tabla alumnos:
EXEC sp_helpindex 'alumnos';
EXEC sp_helpconstraint 'alumnos';


--8-Cree un índice unique no agrupado para el campo "documento".
CREATE UNIQUE INDEX UIX_Documento ON alumnos (documento);


--9-Intente ingresar un alumno con documento duplicado.
INSERT INTO alumnos (legajo, documento, apellido, nombre, nota)
VALUES ('007', '12345678', 'López', 'Martín', 7.8);


--10-Elimine el indice agrupado al campo apellido.
DROP INDEX IX_Apellido ON alumnos;



--11-Regenere el indice del campo legajo para que sea agrupado.
CREATE INDEX PK_Legajo ON alumnos (legajo) WITH drop_existing;
