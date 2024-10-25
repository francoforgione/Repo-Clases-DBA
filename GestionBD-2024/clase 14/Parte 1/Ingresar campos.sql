-- Ingresar campos

-- Trabajamos con la tabla "libros" que almacena los datos de los libros de una librería.

-- Eliminamos la tabla:

  drop table libros;
-- Creamos la tabla:

 create table libros(
  codigo number(5) not null,
  titulo varchar2(40) not null,
  autor varchar2(30),
  editorial varchar2(15)
 );
-- Si ingresamos valores para todos los campos, podemos omitir la lista de campos:

 insert into libros
  values (1,'Uno','Richard Bach','Planeta');
-- Podemos ingresar valores para algunos de los campos:

 insert into libros (codigo, titulo, autor)
  values (2,'El aleph','Borges');
-- Veamos cómo Oracle almacenó los registros:

 select *from libros;
-- En el campo "editorial", para el cual no ingresamos valor, se almacenó "null".

-- No podemos omitir el valor para un campo declarado "not null", como el campo "codigo":

 insert into libros (titulo, autor,editorial)
  values ('Alicia en el pais de las maravillas','Lewis Carroll','Planeta');
-- aparece un mensaje y la inserción no se realiza.

-- Veamos cómo Oracle almacenó los registros:

 select *from libros;
-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  codigo number(5) not null,
  titulo varchar2(40) not null,
  autor varchar2(30),
  editorial varchar2(15)
 );

 insert into libros
  values (1,'Uno','Richard Bach','Planeta');

 insert into libros (codigo, titulo, autor)
  values (2,'El aleph','Borges');

 select *from libros;

 insert into libros (titulo, autor,editorial)
  values ('Alicia en el pais de las maravillas','Lewis Carroll','Planeta');

 select *from libros;