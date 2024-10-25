-- in

-- Trabajamos con la tabla "libros" de una librería.

-- Eliminamos la tabla:

  drop table libros;
-- Creamos la tabla:

 create table libros(
  codigo number (5),
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
  values(4,'Matematica estas ahi','Paenza','Siglo XXI',15);
 insert into libros
  values(5,'Antología poética',default,default,32);
 insert into libros
  values(6,'Martin Fierro','Jose Hernandez',default,40);
 insert into libros
  values(7,'Aprenda PHP','Mario Molina',default,56.50);
-- Recuperamos los libros cuyo autor es "Paenza" o "Borges":

 select *from libros
  where autor in('Borges','Paenza');
-- Note que los valores "null" no se consideran.

-- Recuperamos los libros cuyo autor NO es "Paenza" ni "Borges":

 select *from libros
  where autor not in ('Borges','Paenza');
-- Note que los valores "null" no se consideran.

-- Recuperamos los libros cuyo código se encuentre en la siguiente lista de valores (1,3,5,7,9):

 select *from libros
  where codigo in (1,3,5,7,9);
-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  codigo number (5),
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
  values(4,'Matematica estas ahi','Paenza','Siglo XXI',15);
 insert into libros
  values(5,'Antología poética',default,default,32);
 insert into libros
  values(6,'Martin Fierro','Jose Hernandez',default,40);
 insert into libros
  values(7,'Aprenda PHP','Mario Molina',default,56.50);

 select *from libros
  where autor in('Borges','Paenza');

 select *from libros
  where autor not in ('Borges','Paenza');

 select *from libros
  where codigo in (1,3,5,7,9);