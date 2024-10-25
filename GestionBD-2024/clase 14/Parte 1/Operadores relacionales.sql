-- Operadores relacionales

-- Trabajamos con la tabla "libros" de una librería.
-- Eliminamos la tabla "libros":

  drop table libros;
-- La creamos con la siguiente estructura:

 create table libros(
  titulo varchar2(30),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(5,2)
 );
-- Agregamos registros a la tabla:

 insert into libros (titulo,autor,editorial,precio)
  values ('El aleph','Borges','Emece',24.50);
 insert into libros (titulo,autor,editorial,precio)
  values ('Martin Fierro','Jose Hernandez','Emece',16.00);
 insert into libros (titulo,autor,editorial,precio)
  values ('Aprenda PHP','Mario Molina','Emece',35.40);
 insert into libros (titulo,autor,editorial,precio)
  values ('Cervantes y el quijote','Borges','Paidos',50.90);
-- Seleccionamos los registros cuyo autor sea diferente de 'Borges':

 select *from libros
  where autor<>'Borges';
-- Seleccionamos los registros cuyo precio supere los 20 pesos, sólo el título y precio:

 select titulo,precio
  from libros
  where precio>20;
-- Note que el valor con el cual comparamos el campo "precio", como es numérico, no se coloca entre comillas. Los libros cuyo precio es menor a 20 pesos no aparecen en la selección.

-- Recuperamos aquellos libros cuyo precio es menor o igual a 30:

 select *from libros
  where precio<=30;
-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  titulo varchar2(30),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(5,2)
 );

 insert into libros (titulo,autor,editorial,precio)
  values ('El aleph','Borges','Emece',24.50);
 insert into libros (titulo,autor,editorial,precio)
  values ('Martin Fierro','Jose Hernandez','Emece',16.00);
 insert into libros (titulo,autor,editorial,precio)
  values ('Aprenda PHP','Mario Molina','Emece',35.40);
 insert into libros (titulo,autor,editorial,precio)
  values ('Cervantes y el quijote','Borges','Paidos',50.90);

 select *from libros
  where autor<>'Borges';

 select titulo,precio
  from libros
  where precio>20;

 select *from libros
  where precio<=30;
