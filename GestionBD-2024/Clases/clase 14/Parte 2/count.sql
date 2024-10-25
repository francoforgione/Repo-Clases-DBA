-- count

-- Trabajamos con la tabla "libros" de una librería.

-- Eliminamos la tabla:

  drop table libros;
-- Creamos la tabla:

 create table libros(
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar(20),
  precio number(6,2)
 );
-- Ingresamos algunos registros:

 insert into libros
  values('El aleph','Borges','Emece',15.90);
 insert into libros
  values('Antología poética',null,'Planeta',null);
 insert into libros
  values('Alicia en el pais de las maravillas','Lewis Carroll',null,19.90);
 insert into libros
  values('Matematica estas ahi','Paenza','Siglo XXI',15);
 insert into libros
  values('Martin Fierro','Jose Hernandez',default,40);
 insert into libros
  values('Aprenda PHP',default,'Nuevo siglo',null);
 insert into libros
  values('Uno','Richard Bach','Planeta',20);
-- Averiguemos la cantidad de libros usando la función "count()":

 select count(*)
  from libros;
-- Note que incluye todos los libros aunque tengan valor nulo en algún campo.

-- Contamos los libros de editorial "Planeta":

 select count(*)
  from libros
  where editorial='Planeta';
-- Existen 2 libros de editorial "Planeta".

-- Contamos los registros que tienen precio (sin tener en cuenta los que tienen valor nulo), usando la función "count(precio)":

 select count(precio)
  from libros;
-- La consulta nos retorna el valor 5.

-- Contamos los registros que tienen valor diferente de "null" en "editorial":

 select count(editorial)
  from libros;
-- La consulta nos retorna el valor 5.

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar(20),
  precio number(6,2)
 );

 insert into libros
  values('El aleph','Borges','Emece',15.90);
 insert into libros
  values('Antología poética',null,'Planeta',null);
 insert into libros
  values('Alicia en el pais de las maravillas','Lewis Carroll',null,19.90);
 insert into libros
  values('Matematica estas ahi','Paenza','Siglo XXI',15);
 insert into libros
  values('Martin Fierro','Jose Hernandez',default,40);
 insert into libros
  values('Aprenda PHP',default,'Nuevo siglo',null);
 insert into libros
  values('Uno','Richard Bach','Planeta',20);

 select count(*)
  from libros;

 select count(*)
  from libros
  where editorial='Planeta';

 select count(precio)
  from libros;

 select count(editorial)
  from libros;