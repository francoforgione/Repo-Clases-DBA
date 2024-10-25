-- Subconsultas any - some - all

-- Trabajamos con las tablas "libros" y "editoriales" de una librería.
-- Las creamos:

 create table editoriales(
  codigo serial,
  nombre varchar(30),
  primary key (codigo)
 );
 
 create table libros (
  codigo serial,
  titulo varchar(40),
  autor varchar(30),
  codigoeditorial smallint,
  precio decimal(5,2),
  primary key(codigo)
 );
-- Ingresamos algunos registros:

 insert into editoriales(nombre) values('Planeta');
 insert into editoriales(nombre) values('Emece');
 insert into editoriales(nombre) values('Paidos');
 insert into editoriales(nombre) values('Siglo XXI');

 insert into libros(titulo,autor,codigoeditorial,precio) values('Uno','Richard Bach',1,15);
 insert into libros(titulo,autor,codigoeditorial,precio) values('Ilusiones','Richard Bach',4,18);
 insert into libros(titulo,autor,codigoeditorial,precio) values('Puente al infinito','Richard Bach',2,20);
 insert into libros(titulo,autor,codigoeditorial,precio) values('Aprenda PHP','Mario Molina',4,40);
 insert into libros(titulo,autor,codigoeditorial,precio) values('El aleph','Borges',2,10);
 insert into libros(titulo,autor,codigoeditorial,precio) values('Antología','Borges',1,20);
 insert into libros(titulo,autor,codigoeditorial,precio) values('Cervantes y el quijote','Borges',3,25);
-- Mostramos los títulos de los libros de "Borges" de editoriales que han publicado también libros de "Richard Bach":

 select titulo
  from libros
  where autor like '%Borges%' and
  codigoeditorial = any
   (select e.codigo
    from editoriales as e
    join libros as l
    on codigoeditorial=e.codigo
    where l.autor like '%Bach%');
-- Realizamos la misma consulta pero empleando "all" en lugar de "any":

 select titulo
  from libros
  where autor like '%Borges%' and
  codigoeditorial = all
   (select e.codigo
    from editoriales as e
    join libros as l
    on codigoeditorial=e.codigo
    where l.autor like '%Bach%');
-- Mostramos los títulos y precios de los libros "Borges" cuyo precio supera a ALGUN precio de los libros de "Richard Bach":

 select titulo,precio
  from libros
  where autor like '%Borges%' and
  precio > any
   (select precio
    from libros
    where autor like '%Bach%');
-- Veamos la diferencia si empleamos "all" en lugar de "any":

 select titulo,precio
  from libros
  where autor like '%Borges%' and
  precio > all
   (select precio
    from libros
    where autor like '%Bach%');
-- Empleamos la misma subconsulta para eliminación:

 delete from libros
  where autor like '%Borges%' and
  precio > all
   (select precio
    from libros
    where autor like '%Bach%');