-- truncate table

-- Trabajamos con la tabla "libros" que almacena los datos de los libros de una librería.

-- Eliminamos la tabla:

  drop table libros;
-- Creamos la tabla:

 create table libros(
  codigo number(4),
  titulo varchar2(30),
  autor varchar2(20),
  editorial varchar2(15),
  precio number(5,2)
 );
-- Agregamos algunos registros:

 insert into libros (codigo,titulo,autor,editorial,precio)
  values (1,'El aleph','Borges','Emece',25.60);
 insert into libros (codigo,titulo,autor,editorial,precio)
  values (2,'Uno','Richard Bach','Planeta',18);
-- Seleccionamos todos los registros:

 select *from libros;
-- Truncamos la tabla:

 truncate table libros;
-- Si consultamos la tabla, vemos que aún existe pero ya no tiene registros:

 select *from libros;
-- Ingresamos nuevamente algunos registros:

 insert into libros (codigo,titulo,autor,editorial,precio)
  values (1,'El aleph','Borges','Emece',25.60);
 insert into libros (codigo,titulo,autor,editorial,precio)
  values (2,'Uno','Richard Bach','Planeta',18);
-- Eliminemos todos los registros con "delete":

 delete from libros;
-- Si consultamos la tabla, vemos que aún existe pero ya no tiene registros:

 select *from libros;
-- Ingresamos nuevamente algunos registros:

 insert into libros (codigo,titulo,autor,editorial,precio)
  values (1,'El aleph','Borges','Emece',25.60);
 insert into libros (codigo,titulo,autor,editorial,precio)
  values (2,'Uno','Richard Bach','Planeta',18);
-- Eliminamos la tabla:

 drop table libros;
-- Intentamos seleccionar todos los registros:

 select *from libros;
-- Aparece un mensaje de error, la tabla no existe.

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  codigo number(4),
  titulo varchar2(30),
  autor varchar2(20),
  editorial varchar2(15),
  precio number(5,2)
 );

 insert into libros (codigo,titulo,autor,editorial,precio)
  values (1,'El aleph','Borges','Emece',25.60);
 insert into libros (codigo,titulo,autor,editorial,precio)
  values (2,'Uno','Richard Bach','Planeta',18);

 select *from libros;

 truncate table libros;

 select *from libros;

 insert into libros (codigo,titulo,autor,editorial,precio)
  values (1,'El aleph','Borges','Emece',25.60);
 insert into libros (codigo,titulo,autor,editorial,precio)
  values (2,'Uno','Richard Bach','Planeta',18);

 delete from libros;

 select *from libros;

 insert into libros (codigo,titulo,autor,editorial,precio)
  values (1,'El aleph','Borges','Emece',25.60);
 insert into libros (codigo,titulo,autor,editorial,precio)
  values (2,'Uno','Richard Bach','Planeta',18);

 drop table libros;

 select *from libros;