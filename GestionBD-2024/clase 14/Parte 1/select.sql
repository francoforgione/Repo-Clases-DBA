-- select

-- Trabajamos con la tabla "libros" que almacena los datos de los libros de una librería.
-- Eliminamos la tabla:

drop table libros;
-- Creamos la tabla:

 create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(6,2),
  cantidad number(3,0)
 );
-- Veamos la estructura de la tabla (5 campos):

 describe libros;
-- Ingresamos algunos registros:

 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El aleph','Borges','Emece',25.50,100);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Alicia en el pais de las maravillas','Lewis Carroll','Atlantida',10,200);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Matematica estas ahi','Paenza','Siglo XXI',18.8,200);
-- Veamos todos los campos la tabla:

 select *from libros;
-- Aparece la siguiente tabla:

-- TITULO					AUTOR		EDITORIAL	PRECIO	CANTIDAD
------------------------------------------------------------------------------------------
-- El aleph				Borges		Emece		25.50	100
-- Alicia en el pais de las maravillas	Lewis Carroll	Atlantida	10	200
-- Matematica estas ahi			Paenza		Siglo XXI	18.8	200
-- Recuperamos solamente el título, autor y editorial de todos los libros especificando los nombres de los campos separados por comas:

 select titulo,autor,editorial from libros; 
-- Aparece la siguiente tabla:

-- TITULO					AUTOR		EDITORIAL
-----------------------------------------------------------------
-- El aleph				Borges		Emece
-- Alicia en el pais de las maravillas	Lewis Carroll	Atlantida
-- Matematica estas ahi			Paenza		Siglo XXI
-- Con la siguiente sentencia seleccionamos los títulos y precios de todos los libros:

 select titulo,precio from libros;
-- Aparece la siguiente tabla:

-- TITULO					PRECIO
-----------------------------------------------
-- El aleph				25.50
-- Alicia en el pais de las maravillas	10
-- Matematica estas ahi			18.8
-- Para ver solamente la editorial y la cantidad de libros, tipeamos:

 select editorial,cantidad from libros; 
-- Aparece la siguiente tabla:

-- EDITORIAL	CANTIDAD
-------------------------
-- Emece		100
-- Atlantida	200
-- Siglo XXI	200
-- Note que en todos los casos recuperamos TODOS los registros, pero solamente ALGUNOS campos que especificamos.

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(6,2),
  cantidad number(3,0)
 );

 describe libros;

 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El aleph','Borges','Emece',25.50,100);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Alicia en el pais de las maravillas','Lewis Carroll','Atlantida',10,200);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Matematica estas ahi','Paenza','Siglo XXI',18.8,200);

 select *from libros;

 select titulo,autor,editorial from libros; 

 select titulo,precio from libros;

 select editorial,cantidad from libros; 