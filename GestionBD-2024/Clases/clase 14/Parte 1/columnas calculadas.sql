-- columnas calculadas

-- Trabajamos con la tabla "libros" de una librería.

-- Eliminamos la tabla:

  drop table libros;
-- Creamos la tabla:

 create table libros(
  codigo number(5),
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  precio number(6,2),
  cantidad number(4) default 0,
  primary key (codigo)
 );
-- Ingresamos algunos registros:

 insert into libros (codigo,titulo,autor,editorial,precio)
  values(1,'El aleph','Borges','Emece',25);
 insert into libros
  values(2,'Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);
 insert into libros (codigo,titulo,autor,editorial,precio,cantidad)
  values(3,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,50);
-- Queremos saber el monto total en dinero de cada libro:

 select titulo, precio,cantidad,
  precio*cantidad
  from libros;
-- Queremos saber el precio de cada libro con un 10% de descuento:

 select titulo,precio,
  precio-(precio*0.1)
  from libros;
-- Actualizamos los precios con un 10% de descuento y vemos el resultado:

 update libros set precio=precio-(precio*0.1);
 select *from libros;
-- Queremos una columna con el título y autor de cada libro:

 select titulo||'-'||autor
  from libros;
-- Mostramos el título y precio de cada libro concatenados:

 select titulo||' $'||precio
  from libros;
-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  codigo number(5),
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  precio number(6,2),
  cantidad number(4) default 0,
  primary key (codigo)
 );

 insert into libros (codigo,titulo,autor,editorial,precio)
  values(1,'El aleph','Borges','Emece',25);
 insert into libros
  values(2,'Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);
 insert into libros (codigo,titulo,autor,editorial,precio,cantidad)
  values(3,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,50);

 select titulo, precio,cantidad,
  precio*cantidad
  from libros;

 select titulo,precio,
  precio-(precio*0.1)
  from libros;

 update libros set precio=precio-(precio*0.1);
 select *from libros;

 select titulo||'-'||autor
  from libros;

 select titulo||' $'||precio
  from libros;