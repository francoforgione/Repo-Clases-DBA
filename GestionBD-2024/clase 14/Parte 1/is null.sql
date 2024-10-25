-- is null

-- Trabajamos con la tabla "libros" de una librería.
-- Eliminamos la tabla y la creamos:

 drop table libros;
 
 create table libros(
  codigo number(4) not null,
  titulo varchar2(40) not null,
  autor varchar2(20),
  editorial varchar2(20),
  precio number(6,2)
 );
-- Ingresamos algunos registros:

 insert into libros
  values(1,'El aleph','Borges','Emece',15.90);
 insert into libros
  values(2,'Cervantes y el quijote','Borges','Paidos',null);
 insert into libros
  values(3,'Alicia en el pais de las maravillas','Lewis Carroll',null,19.90);
 insert into libros
  values(4,'Martin Fierro','Jose Hernandez','Emece',25.90);
 insert into libros (codigo,titulo,autor,precio)
  values(5,'Antología poética','Borges',25.50);
 insert into libros (codigo,titulo,autor)
  values(6,'Java en 10 minutos','Mario Molina');
 insert into libros (codigo,titulo,autor)
  values(7,'Martin Fierro','Jose Hernandez');
 insert into libros (codigo,titulo,autor)
  values(8,'Aprenda PHP',null);
-- Recuperamos los registros en los cuales esté almacenado el valor "null" en el campo "editorial":

 select *from libros
  where editorial is null;
-- Seleccionamos los libros que no contiene "null" en "autor":

 select *from libros
  where editorial is not null;
-- Dijimos que una cadena de espacios NO es igual a una cadena vacía o valor "null". Vamos a ingresar un registro y en el campo "editorial" guardaremos una cadena de 3 espacios:

insert into libros (codigo,titulo,autor,editorial,precio)
  values(9,'Don quijote','Cervantes','   ',20);
-- Veamos cómo se almacenó el registro:

 select *from libros;
-- Se muestra la cadena de espacios.

-- Recuperamos los registros que contengan el valor "null" en el campo "editorial" y luego aquellos que tengan una cadena de 3 espacios:

 select *from libros where editorial is null;
 select *from libros where editorial='   ';
-- Con la primera sentencia veremos los libros cuya editorial es igual a "null" (desconocido); con la segunda, los libros cuya editorial almacena una cadena de espacios.

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;
 
 create table libros(
  codigo number(4) not null,
  titulo varchar2(40) not null,
  autor varchar2(20),
  editorial varchar2(20),
  precio number(6,2)
 );

 insert into libros
  values(1,'El aleph','Borges','Emece',15.90);
 insert into libros
  values(2,'Cervantes y el quijote','Borges','Paidos',null);
 insert into libros
  values(3,'Alicia en el pais de las maravillas','Lewis Carroll',null,19.90);
 insert into libros
  values(4,'Martin Fierro','Jose Hernandez','Emece',25.90);
 insert into libros (codigo,titulo,autor,precio)
  values(5,'Antología poética','Borges',25.50);
 insert into libros (codigo,titulo,autor)
  values(6,'Java en 10 minutos','Mario Molina');
 insert into libros (codigo,titulo,autor)
  values(7,'Martin Fierro','Jose Hernandez');
 insert into libros (codigo,titulo,autor)
  values(8,'Aprenda PHP',null);

 select *from libros
  where editorial is null;

 select *from libros
  where editorial is not null;

insert into libros (codigo,titulo,autor,editorial,precio)
  values(9,'Don quijote','Cervantes','   ',20);

 select *from libros;

 select *from libros where editorial is null;

 select *from libros where editorial='   ';