-- Necesitamos almacenar en una tabla llamada "usuarios" los datos de los usuarios 
-- de un sitio web. Cada vez que el usuario cambia su clave se debe almacenar en 
-- otra tabla llamada "clavesanteriores" el dato de la clave vieja.

-- Borramos las dos tablas si existen:

drop table if exists usuarios;
drop table if exists clavesanteriores;

-- Creamos ambas tablas con las siguientes estructuras:

create table usuarios(
 nombre varchar(30),
 clave varchar(30),
 primary key (nombre)
);

create table clavesanteriores(
 numero int auto_increment,
 nombre varchar(30),
 clave varchar(30),
 primary key (numero)
);

-- Si existe el trigger 'before_usuarios_update' procedemos a borrarlo:

drop trigger if exists before_usuarios_update;

-- Creamos el trigger 'before_usuarios_update':

delimiter //
create trigger before_usuarios_update
  before update
  on usuarios
  for each row
begin
  insert into clavesanteriores(nombre, clave) values (old.nombre, old.clave); 
end //
delimiter ;

-- Este trigger se dispara cada vez que ejecutemos el comando SQL 'update' con la 
-- tabla 'usuarios':

  -- before update
  -- on usuarios

-- El bloque del disparador se encuentra encerrado entre las palabras claves 'begin'
--  y 'end'. Nuestro algoritmo es ejecutar un comando SQL insert en la tabla 
-- 'clavesanteriores' insertando el nombre de usuario y clave previo a ser cambiado 
-- por el comando 'update' en la tabla 'usuarios'.

-- Mediante las palabras claves 'old' y 'new' podemos acceder a los valores actuales 
-- de la fila y los valores que se actualizarán en la tabla 'usuarios':

-- old.nombre y old.clave
-- new.nombre y new.clave

-- Ejecutemos ahora un insert en la tabla 'usuarios':

insert into usuarios(nombre,clave) values ('marcos','123abc');

select * from usuarios;

-- El trigger no se ejecuta ya que solo hemos definido que se dispare para el 
-- comando 'update'.

-- Ahora procedamos a modificar la clave del usuario mediante el comando 'update':

update usuarios set clave='999zzz' where nombre='marcos';

-- Cuando se ejecuta el 'update' además de actualizarse la clave del usuario en la 
-- tabla 'usuarios' se dispara el trigger donde se efectúa la inserción de una fila 
-- en la tabla 'clavesanteriores'.

-- Listemos la tabla 'clavesanteriores'

select * from clavesanteriores;

-- Podemos comprobar que tenemos ahora una fila que contiene los datos:

-- nombre: marcos
-- clave: 123abc

-- Si volvemos a cambiar la clave del usuario 'marcos':

update usuarios set clave='123456' where nombre='marcos';

-- Listamos nuevamente la tabla 'clavesanteriores':

select * from clavesanteriores;

-- Podemos comprobar que tenemos ahora dos filas que contiene los datos:

-- nombre: marcos
-- clave: 123abc
-- nombre: marcos
-- clave: 999zzz

-- Con el trigger logramos tener el historial de todas las claves empleadas por los 
-- usuarios. Tener en cuenta que la última clave elegida por el usuario se encuentra 
-- en la tabla 'usuarios':

select * from usuarios;