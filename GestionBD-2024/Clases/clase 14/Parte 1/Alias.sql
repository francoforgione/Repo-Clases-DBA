-- Alias

-- Trabajamos con nuestra tabla "libros".

-- Eliminamos la tabla:

  drop table libros;
-- Creamos la tabla:

 create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(5,2),
  cantidad number(4)
 );
-- Ingresamos algunos registros:

 insert into libros
  values('Uno','Richard Bach','Planeta',15,100);
 insert into libros
  values('El aleph','Borges','Emece',24,150);
 insert into libros
  values('Matematica estas ahi','Paenza','Nuevo siglo',12.5,200);
-- Mostramos la información con el encabezado "stock" para el campo "cantidad":

 select titulo,
  cantidad as stock,
  precio
  from libros;
-- Mostramos la información con el encabezado "stock disponible" para el campo "cantidad", necesitamos emplear comillas dobles:

 select titulo,
  cantidad as "stock disponible",
  precio
  from libros;
-- Recuperamos el título, autor, precio, descuento del 10% y precio final con descuento, empleando un alias para las 2 últimas columnas:

 select titulo,autor,precio,
  precio*0.1 as descuento,
  precio-(precio*0.1) as "precio final"
  from libros;
-- La palabra clave "as" es opcional, podemos obviarla:

 select titulo,precio,
  precio-(precio*0.1) "precio con descuento"
  from libros;
-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(5,2),
  cantidad number(4)
 );

 insert into libros
  values('Uno','Richard Bach','Planeta',15,100);
 insert into libros
  values('El aleph','Borges','Emece',24,150);
 insert into libros
  values('Matematica estas ahi','Paenza','Nuevo siglo',12.5,200);

 select titulo,
  cantidad as stock,
  precio
  from libros;

 select titulo,
  cantidad as "stock disponible",
  precio
  from libros;

 select titulo,autor,precio,
  precio*0.1 as descuento,
  precio-(precio*0.1) as "precio final"
  from libros;

 select titulo,precio,
  precio-(precio*0.1) "precio con descuento"
  from libros;