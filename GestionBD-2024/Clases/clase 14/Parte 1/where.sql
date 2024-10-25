-- where

-- Trabajamos con la tabla "usuarios" que consta de 2 campos: nombre de usuario y clave.
-- Eliminamos la tabla si ya existe:

  drop table usuarios;
-- Creamos la tabla:

 create table usuarios (
  nombre varchar2(30),
  clave varchar2(10)
 );
-- Vemos la estructura de la tabla:

 describe usuarios;
-- Ingresamos algunos registros:

 insert into usuarios (nombre, clave)
  values ('Marcelo','Boca');
 insert into usuarios (nombre, clave)
  values ('JuanPerez','Juancito');
 insert into usuarios (nombre, clave)
  values ('Susana','River');
 insert into usuarios (nombre, clave)
  values ('Luis','River');
-- Realizamos una consulta especificando una condición, queremos ver toda la información del usuario cuyo nombre es "Marcelo":

 select *from usuarios
  where nombre='Marcelo';
-- Nos muestra todos los campos del registro en el cual el campo "nombre" es igual a "Marcelo".

-- Queremos ver el nombre de los usuarios cuya clave es "River":

 select nombre from usuarios
  where clave='River';
-- Nos muestra 2 usuarios.

-- Realizamos un "select" de los nombres de los usuarios cuya clave es "Santi":

 select nombre from usuarios
  where clave='Santi';
-- No se muestra ningún registro ya que ninguno cumple la condición.

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table usuarios;
 
 create table usuarios (
  nombre varchar2(30),
  clave varchar2(10)
 );

 describe usuarios;

 insert into usuarios (nombre, clave)
  values ('Marcelo','Boca');
 insert into usuarios (nombre, clave)
  values ('JuanPerez','Juancito');
 insert into usuarios (nombre, clave)
  values ('Susana','River');
 insert into usuarios (nombre, clave)
  values ('Luis','River');

 select *from usuarios
  where nombre='Marcelo';

 select nombre from usuarios
  where clave='River';

 select nombre from usuarios
  where clave='Santi';