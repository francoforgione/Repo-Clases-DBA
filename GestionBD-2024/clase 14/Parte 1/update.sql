-- update

-- Trabajamos con la tabla "usuarios".
-- Eliminamos la tabla:

  drop table usuarios;
-- Creamos la tabla:

 create table usuarios(
  nombre varchar2(20),
  clave varchar2(10)
 );
-- Ingresamos algunos registros:

 insert into usuarios (nombre,clave)
  values ('Marcelo','River');
 insert into usuarios (nombre,clave)
  values ('Susana','chapita');
 insert into usuarios (nombre,clave)
  values ('Carlosfuentes','Boca');
 insert into usuarios (nombre,clave)
  values ('Federicolopez','Boca');
-- Cambiaremos los valores de todas las claves, por la cadena "RealMadrid":

 update usuarios set clave='RealMadrid';
-- Un mensaje indica que se actualizaron 4 registros.

-- El cambio afectó a todos los registros, veámoslo:

 select *from usuarios;
-- Necesitamos cambiar el valor de la clave del usuario llamado "Federicolopez" por "Boca":

 update usuarios set clave='Boca'
  where nombre='Federicolopez';
-- Verifiquemos que la actualización se realizó:

 select *from usuarios;
-- Vimos que si Oracle no encuentra registros que cumplan con la condición del "where", un mensaje indica que ningún registro se modifica:

 update usuarios set clave='payaso'
  where nombre='JuanaJuarez';
-- Para actualizar varios campos en una sola instrucción empleamos:

 update usuarios set nombre='Marceloduarte', clave='Marce'
  where nombre='Marcelo';
-- Verifiquemos que la actualización se realizó:

 select *from usuarios;
-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table usuarios;

 create table usuarios(
  nombre varchar2(20),
  clave varchar2(10)
 );

 insert into usuarios (nombre,clave)
  values ('Marcelo','River');
 insert into usuarios (nombre,clave)
  values ('Susana','chapita');
 insert into usuarios (nombre,clave)
  values ('Carlosfuentes','Boca');
 insert into usuarios (nombre,clave)
  values ('Federicolopez','Boca');

 update usuarios set clave='RealMadrid';

 select *from usuarios;

 update usuarios set clave='Boca'
  where nombre='Federicolopez';

 select *from usuarios;

 update usuarios set clave='payaso'
  where nombre='JuanaJuarez';

 update usuarios set nombre='Marceloduarte', clave='Marce'
  where nombre='Marcelo';

 select *from usuarios;