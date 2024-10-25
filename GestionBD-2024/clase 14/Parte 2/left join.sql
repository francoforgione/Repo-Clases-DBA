-- left join

-- Una librería almacena la información de sus libros para la venta en dos tablas, "libros" y "editoriales".
-- Eliminamos ambas tablas, las creamos y agregamos a cada una de ellas restricciones únicas para los campos "codigo" de ambas tablas:

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
  direccion varchar2(40)
);
 
 alter table editoriales
  add constraints UQ_editoriales_codigo
  unique (codigo);

 alter table libros
  add constraints UQ_libros_codigo
  unique (codigo);
-- Ingresamos algunos registros en ambas tablas:

 insert into editoriales values(1,'Planeta','Colon 120');
 insert into editoriales values(2,'Emece','Estrada 356');
 insert into editoriales values(3,'Siglo XXI','General Paz 700');
 insert into editoriales values(null,'Sudamericana','Copiapo 343');
 insert into editoriales values(null,'Norma','Bulnes 123');

 insert into libros values(100,'El aleph','Borges',1);
 insert into libros values(200,'Martin Fierro','Jose Hernandez',1);
 insert into libros values(300,'Aprenda PHP','Mario Molina',2);
 insert into libros values(400,'Java en 10 minutos',default,4);
 insert into libros values(500,'El quijote de la mancha','Cervantes',null);
-- Realizamos una combinación izquierda para obtener los títulos de los libros, incluyendo el nombre de la editorial:

 select titulo,nombre
  from editoriales e
  left join libros l
  on codigoeditorial = e.codigo;
-- Las editoriales de las cuales no hay libros, es decir, cuyo código de editorial no está presente en "libros" o tienen valor nulo, aparece en el resultado, pero con el valor "null" en el campo "titulo" (caso de "Siglo XXI", "Sudamericana" y "Norma").

-- Realizamos la misma consulta anterior pero cambiamos el orden de las tablas:

  select titulo,nombre
  from libros l
  left join editoriales e
  on codigoeditorial = e.codigo;
-- El resultado mostrará el título del libro y el nombre de la editorial; los títulos cuyo código de editorial no está presente en "editoriales" o tienen valor nulo, aparecen en el resultado, pero con el valor "null" en el campo "nombre" (caso de los libros "El quijote..." y "Java...").

-- Restringimos el resultado de una consulta considerando solamente los registros que encuentran coincidencia en la tabla de la derecha, es decir, cuyo valor de código está presente en "libros":

 select titulo,nombre
  from editoriales e
  left join libros l
  on e.codigo=codigoeditorial
  where codigoeditorial is not null;
-- Mostramos las editoriales que NO están presentes en "libros", es decir, que NO encuentran coincidencia en la tabla de la derecha:

 select nombre
  from editoriales e
  left join libros l
  on e.codigo=codigoeditorial
  where codigoeditorial is null;
-- Aparecen 3 editoriales.

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
  nombre varchar2(20)
 );
 
 alter table editoriales
  add constraints UQ_editoriales_codigo
  unique (codigo);

 alter table libros
  add constraints UQ_libros_codigo
  unique (codigo);

 insert into editoriales values(1,'Planeta');
 insert into editoriales values(2,'Emece');
 insert into editoriales values(3,'Siglo XXI');
 insert into editoriales values(null,'Sudamericana');
 insert into editoriales values(null,'Norma');

 insert into libros values(100,'El aleph','Borges',1);
 insert into libros values(200,'Martin Fierro','Jose Hernandez',1);
 insert into libros values(300,'Aprenda PHP','Mario Molina',2);
 insert into libros values(400,'Java en 10 minutos',default,4);
 insert into libros values(500,'El quijote de la mancha','Cervantes',null);

 select titulo,nombre
  from editoriales e
  left join libros l
  on codigoeditorial = e.codigo;

  select titulo,nombre
   from libros l
   left join editoriales e
   on codigoeditorial = e.codigo;

 select titulo,nombre
  from editoriales e
  left join libros l
  on e.codigo=codigoeditorial
  where codigoeditorial is not null;

 select nombre
  from editoriales e
  left join libros l
  on e.codigo=codigoeditorial
  where codigoeditorial is null;