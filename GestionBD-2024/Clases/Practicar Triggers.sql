CREATE DATABASE IF NOT EXISTS testDisparador;

USE testDisparador;


CREATE TABLE IF NOT EXISTS alumnos (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    nota FLOAT
);


DELIMITER //
CREATE TRIGGER trigger_check_nota_before_insert
BEFORE INSERT ON alumnos
FOR EACH ROW
BEGIN
    IF NEW.nota < 0 THEN	SET NEW.nota = 0;
    ELSEIF NEW.nota > 10 THEN	SET NEW.nota = 10;
    END IF;
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER trigger_check_nota_before_update
BEFORE UPDATE ON alumnos
FOR EACH ROW
BEGIN
    IF NEW.nota < 0 THEN  SET NEW.nota = 0;
    ELSEIF NEW.nota > 10 THEN  SET NEW.nota = 10;
    END IF;
END;
//
DELIMITER ;

SELECT * FROM alumnos;

INSERT INTO alumnos (nombre, apellido, nota) VALUES ('Juan', 'Perez', 8);
INSERT INTO alumnos (nombre, apellido, nota) VALUES ('Maria', 'Gomez', -3);
INSERT INTO alumnos (nombre, apellido, nota) VALUES ('Pedro', 'Lopez', 12);


UPDATE alumnos SET nota = 9 WHERE id = 1;
UPDATE alumnos SET nota = -2 WHERE id = 2;
UPDATE alumnos SET nota = 11 WHERE id = 3;