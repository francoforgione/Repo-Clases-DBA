-- Trabajo Práctico Sistema de Usuarios y Permisos

-- 1 - Crear un usuario sin privilegios específicos
CREATE USER 'pepe'@'localhost' IDENTIFIED BY '123';
-- VALIDACION 
SHOW GRANTS FOR  'pepe'@'localhost';

-- 2 - Crear un usuario con privilegios de lectura sobre la base pubs
CREATE USER 'pepe2'@'localhost' IDENTIFIED BY '123';
GRANT SELECT ON pubs.* TO 'pepe2'@'localhost';

-- 3 - Crear un usuario con privilegios de escritura sobre la base pubs
CREATE USER 'pepe3'@'localhost' IDENTIFIED BY '123';
GRANT insert, update ON pubs.* TO 'pepe3'@'localhost';

-- 4 - Crear un usuario con todos los privilegios sobre la base pubs
create user 'pepe4'@'localhost' IDENTIFIED BY '123';
GRANT ALL PRIVILEGES ON pubs.* TO 'pepe4'@'localhost'  WITH GRANT OPTION;

-- 5 - Crear un usuario con privilegios de lectura sobre la tabla titles
create user 'pepe5'@'localhost' IDENTIFIED BY '123';
GRANT SELECT ON pubs.titles TO 'pepe5'@'localhost';

-- 6 - Eliminar al usuario que tiene todos los privilegios sobre la base pubs
DROP USER 'pepe4'@'localhost';

-- 7 - Eliminar a dos usuarios a la vez
 DROP USER 'pepe'@'localhost','pepe2'@'localhost';

-- 8 - Eliminar un usuario y sus privilegios asociados
 DROP USER 'pepe3'@'localhost';

-- 9 - Revisar los privilegios de un usuario
 SELECT * FROM mysql.user;
