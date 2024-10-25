-- Tipos de datos

-- Eliminamos la tabla "libros":

 drop table libros;
-- Vamos a crear una tabla llamada "libros" para almacenar información de los libros de una librería. Necesitamos los siguientes campos:

 -- -titulo: cadena de caracteres de 20 de longitud,
 -- -autor: cadena de caracteres de 15 de longitud,
 -- -editorial: caracteres de 10 de longitud,
 -- -precio: valor numérico con 2 decimales y que no superará el valor 9999.99 y
 -- -cantidad: valor numérico entero que no superará el valor 999.
-- Al crear la tabla, entonces, elegimos el tipo de dato más adecuado para cada campo:

 create table libros(
  titulo varchar2(20),
  autor varchar2(15),
  editorial varchar2(10),
  precio number(6,2),
  cantidad number(3,0)
 );
-- Vemos la estructura de la tabla:

 describe libros;
-- Aparece la siguiente información:

-- Name	Null	Type
--------------------------------------
-- titulo		varchar2(20)
-- autor		varchar2(15)
-- editorial	varchar2(10)
-- precio		number(6,2)
-- cantidad	number(3)
-- Ingresamos algunos registros:

 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El aleph','Borges','Emece',25.50,100);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Matematica estas ahi','Paenza','Siglo XXI',18.8,200);
-- Note que al ingresar valores numéricos no se utilizan comillas y para el separador de decimales se usa el caracter punto (.).

-- Veamos los registros cargados:

 select * from libros;
-- Aparece la siguiente tabla:

-- TITULO			AUTOR	EDITORIAL	PRECIO	CANTIDAD
----------------------------------------------------------------
-- El Aleph		Borges	Emece		25,5	100
-- Matematica estas ahi	Paenza	Siglo XXI	18,8	200
-- Veamos lo que sucede si intentamos ingresar para el campo "titulo" una cadena de más de 20 caracteres:

 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Alicia en el pais de las maravillas','Lewis Carroll','Atlantida',10,200);
-- aparece un mensaje de error y la sentencia no se ejecuta.

-- vamos a cortar la cadena para que Oracle acepte el ingreso del registro:

 
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Alicia en el pais','Lewis Carroll','Atlantida',10,200);
-- Veamos los registros cargados:

 select * from libros;
-- La tabla tiene ahora 3 registros.

-- Veamos qué sucede si intentamos ingresar para el campo "cantidad" un valor fuera de rango:

 
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El gato con botas','Anonimo','Atlantida',10,2000);
-- Oracle muestra un mensaje de error y la sentencia no se ejecuta, es decir, el registro no fue ingresado.

-- Veamos qué sucede si intentamos ingresar en el campo "precio" un valor con más decimales que los permitidos:

 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El gato con botas','Anonimo','Atlantida',10.123,200);
-- La sentencia se ejecutó, el registro ha sido cargado. Veamos cómo se almacenó:

 select * from libros;
-- Oracle omitió el último dígito decimal porque el campo sólo admitía 2 decimales.

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  titulo varchar2(20),
  autor varchar2(15),
  editorial varchar2(10),
  precio number(6,2),
  cantidad number(3,0)
 );

 describe libros;

 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El aleph','Borges','Emece',25.50,100);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Matematica estas ahi','Paenza','Siglo XXI',18.8,200);

 select * from libros;

 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Alicia en el pais de las maravillas','Lewis Carroll','Atlantida',10,200);
 
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Alicia en el pais','Lewis Carroll','Atlantida',10,200);

 select * from libros;

 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El gato con botas','Anonimo','Atlantida',10,2000);

 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El gato con botas','Anonimo','Atlantida',10.123,200);

 select * from libros;