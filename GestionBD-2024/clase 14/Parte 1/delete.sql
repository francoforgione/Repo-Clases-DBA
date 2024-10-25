-- delete

-- Trabajamos con la tabla "usuarios".
-- Eliminamos la tabla "usuarios":

  drop table usuarios;
-- La creamos con la siguiente estructura:

 create table usuarios(
  nombre varchar2(30),
  clave varchar2(10)
 );
-- Agregamos registros a la tabla:

 insert into usuarios (nombre,clave)
  values ('Marcelo','River');
 insert into usuarios (nombre,clave)
  values ('Susana','chapita');
 insert into usuarios (nombre,clave)
  values ('CarlosFuentes','Boca');
 insert into usuarios (nombre,clave)
  values ('FedericoLopez','Boca');
-- Seleccionamos todos los registros:

 select *from usuarios;
-- Vamos a eliminar el registro cuyo nombre de usuario es "Marcelo":

 delete from usuarios
 where nombre='Marcelo';
-- aparece un mensaje indicando que se ha borrado 1 fila.

-- Intentamos eliminarlo nuevamente:

 delete from usuarios
 where nombre='Marcelo';
-- Como ningún registro cumple con la condición especificada (nombre igual a Marcelo), aparecerá un mensaje indicando que ningún registro fue borrado.

-- Eliminamos todos los registros cuya clave es 'Boca':

 delete from usuarios
  where clave='Boca';
-- Aparece un mensaje indicando que 2 registros fueron eliminados, es decir, se eliminaron los 2 registros cuyas claves eran igual a "River".

-- Eliminemos todos los registros:

 delete from usuarios;
-- Veamos el contenido de la tabla:

 select * from usuarios;
-- No hay registros.

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table usuarios;

 create table usuarios(
  nombre varchar2(30),
  clave varchar2(10)
 );

 insert into usuarios (nombre,clave)
  values ('Marcelo','River');
 insert into usuarios (nombre,clave)
  values ('Susana','chapita');
 insert into usuarios (nombre,clave)
  values ('CarlosFuentes','Boca');
 insert into usuarios (nombre,clave)
  values ('FedericoLopez','Boca');

 select *from usuarios;

 delete from usuarios
   where nombre='Marcelo';

 delete from usuarios
 where nombre='Marcelo';

 delete from usuarios
  where clave='Boca';

 delete from usuarios;

 select * from usuarios;