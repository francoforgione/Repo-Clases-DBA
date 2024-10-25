-- order by

-- Trabajamos con la tabla "libros" de una librería.

-- Eliminamos la tabla y la creamos con la siguiente estructura:

 drop table libros;

 create table libros(
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  edicion date,
  precio number(6,2)
 );
-- Ingresamos algunos registros:

 insert into libros values('El aleph','Borges','Emece','10/10/1980',25.33);
 insert into libros values('Java en 10 minutos','Mario Molina','Siglo XXI','05/12/2005',50.65);
 insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Emece','29/11/2000',19.95);
 insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Planeta','27/11/2004',15);
-- Recuperamos los registros ordenados por el título:

 select *from libros
  order by titulo;
-- Ordenamos los registros por el campo "precio", referenciando el campo por su posición en la lista de selección:

 select titulo,autor,precio
  from libros order by 3;
-- Los ordenamos por "editorial", de mayor a menor empleando "desc":

 select *from libros
  order by editorial desc;
-- Ordenamos por dos campos:

 select *from libros
  order by titulo,editorial;
-- Ordenamos en distintos sentidos:

 select *from libros
  order by titulo asc, editorial desc;
-- Podemos ordenar por un campo que no se lista en la selección:

 select titulo, autor
  from libros
  order by precio;
-- Está permitido ordenar por valores calculados, lo hacemos:

 select titulo, editorial,
 precio+(precio*0.1) as "precio con descuento"
 from libros
 order by 3;
-- Ordenamos los libros por la fecha de edición:

 select titulo, editorial, edicion
  from libros
  order	by edicion;
-- Mostramos el título y año de edición de todos los libros, ordenados por año de edición:

  select titulo, extract (year from edicion) as edicion
   from libros
   order by 2;
-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  edicion date,
  precio number(6,2)
 );

 insert into libros values('El aleph','Borges','Emece','10/10/1980',25.33);
 insert into libros values('Java en 10 minutos','Mario Molina','Siglo XXI','05/12/2005',50.65);
 insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Emece','29/11/2000',19.95);
 insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Planeta','27/11/2004',15);

 select *from libros
  order by titulo;

 select titulo,autor,precio
  from libros order by 3;

 select *from libros
  order by editorial desc;

 select *from libros
  order by titulo,editorial;

 select *from libros
  order by titulo asc, editorial desc;

 select titulo, autor
  from libros
  order by precio;

 select titulo, editorial,
 precio+(precio*0.1) as "precio con descuento"
 from libros
 order by 3;

 select titulo, editorial, edicion
  from libros
  order	by edicion;

 select titulo, extract (year from edicion) as edicion
   from libros
   order by 2;