-- join - combinacion interna

-- Una librería almacena la información de sus libros para la venta en dos tablas, "libros" y "editoriales".
-- Eliminamos ambas tablas:

  drop table libros;
  drop table editoriales;
-- Creamos las tablas:

 create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3)
 );
 create table editoriales(
  codigo number(3),
  nombre varchar2(20),
  direccion varchar2(40),
  primary key (codigo)
);
-- Ingresamos algunos registros en ambas tablas:

 insert into editoriales values(1,'Planeta','Colon 120');
 insert into editoriales values(2,'Emece','Estrada 356');
 insert into editoriales values(3,'Siglo XXI','General Paz 700');

 insert into libros values(100,'El aleph','Borges',1);
 insert into libros values(200,'Martin Fierro','Jose Hernandez',2);
 insert into libros values(300,'Aprenda PHP','Mario Molina',3);
 insert into libros values(400,'Java en 10 minutos',null,5);
 insert into libros values(500,'Matematica estas ahi','Paenza',null);
-- Recuperamos los datos de libros:

 select *from libros;
-- vemos que en el campo "editorial" aparece el código, pero no sabemos el nombre de la editorial y su dirección. Realizamos un join para obtener datos de ambas tablas (titulo, autor y nombre de la editorial):

 select titulo, autor, nombre, direccion
  from libros
  join editoriales
  on codigoeditorial=editoriales.codigo;
-- Note que los libros cuyo código de editorial NO se encuentra en "editoriales" no aparecen en el resultado de la consulta. El libro "Java en 10 minutos" tiene código de editorial 5, y ese código no está presente en "editoriales"; el libro "Matemática estas ahi" tiene valor nulo en "codigoeditorial", por lo tanto, tampoco se muestra en el join.

-- Mostramos el código del libro, título, autor, nombre de la editorial y su dirección realizando un join y empleando alias:

 select l.codigo,titulo,autor,nombre,direccion
  from libros l
  join editoriales e
  on codigoeditorial=e.codigo;
-- Note que al listar el campo "codigo" especificamos a qué tabla pertenece; si no lo hacemos Oracle no sabrá si nos referimos al de la tabla "libros" o "editoriales". Los demás campos no tienen referencia a la tabla porque tienen nombres que no se repiten.

-- Realizamos la misma consulta anterior agregando un "where" para obtener solamente los libros de la editorial "Siglo XXI":

 select l.codigo,titulo,autor,nombre,direccion
  from libros l
  join editoriales e
  on codigoeditorial=e.codigo
  where e.nombre='Siglo XXI';
-- Obtenemos título, autor y nombre de la editorial, esta vez ordenados por título:

 select titulo,autor,nombre
  from libros l
  join editoriales e
  on codigoeditorial=e.codigo
  order by titulo;
-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;
 drop table editoriales;

 create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3)
 );
 create table editoriales(
  codigo number(3),
  nombre varchar2(20),
  direccion varchar2(40),
  primary key (codigo)
);

 insert into editoriales values(1,'Planeta','Colon 120');
 insert into editoriales values(2,'Emece','Estrada 356');
 insert into editoriales values(3,'Siglo XXI','General Paz 700');

 insert into libros values(100,'El aleph','Borges',1);
 insert into libros values(200,'Martin Fierro','Jose Hernandez',2);
 insert into libros values(300,'Aprenda PHP','Mario Molina',3);
 insert into libros values(400,'Java en 10 minutos',null,5);
 insert into libros values(500,'Matematica estas ahi','Paenza',null);

 select *from libros;

 select titulo, autor, nombre, direccion
  from libros
  join editoriales
  on codigoeditorial=editoriales.codigo;

 select l.codigo,titulo,autor,nombre
  from libros l
  join editoriales e
  on codigoeditorial=e.codigo;

 select l.codigo,titulo,autor,nombre,direccion
  from libros l
  join editoriales e
  on codigoeditorial=e.codigo
  where e.nombre='Siglo XXI';

 select titulo,autor,nombre
  from libros l
  join editoriales e
  on codigoeditorial=e.codigo
  order by titulo;

