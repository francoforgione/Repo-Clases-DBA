create database prueba

use prueba

--CREACION DE INDICES

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15)
 )

--Creamos un �ndice agrupado �nico para el campo "codigo" de la tabla "libros":

 create unique clustered index I_libros_codigo
 on libros(codigo)

--Creamos un �ndice no agrupado para el campo "titulo":

 create nonclustered index I_libros_titulo
 on libros(titulo)

--Veamos los indices de "libros":

 sp_helpindex libros

--Aparecen 2 filas, uno por cada �ndice. Muestra el nombre del �ndice, si es agrupado (o no),
--primary (o unique) y el campo por el cual se indexa.

--Creamos una restricci�n "primary key" al campo "codigo" especificando que cree un �ndice 
--NO agrupado:

  alter table libros
  add constraint PK_libros_codigo
  primary key nonclustered (codigo)

--Verificamos que cre� un �ndice autom�ticamente:

 sp_helpindex libros

--El nuevo �ndice es agrupado, porque no se especific�.

--Analicemos la informaci�n que nos muestra "sp_helpconstraint":

 sp_helpconstraint libros
 

--En la columna "constraint_type" aparece "PRIMARY KEY" y entre par�ntesis, el tipo de �ndice
--creado.

--Creamos un �ndice compuesto para el campo "autor" y "editorial":

 create index I_libros_autoreditorial
 on libros(autor,editorial)

--Se crear� uno no agrupado porque no especificamos el tipo, adem�s, ya existe uno agrupado y
--solamente puede haber uno por tabla.

--Consultamos la tabla "sysindexes":

 select name from sysindexes

--Veamos los �ndices de la base de datos activa creados por nosotros podemos tipear la siguien
--te consulta:

 select name from sysindexes
 where name like 'I_%'
 
 
 drop table libros
 
 
 
--REGENERACION DE INDICES
 
  create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15)
 )

--Creamos un �ndice no agrupado para el campo "titulo":

 create nonclustered index I_libros_titulo
 on libros(titulo)

--Veamos la informaci�n:

 sp_helpindex libros
 
 
--Empleando la opci�n "drop_existing" junto con "create index" permite regenerar un 
--�ndice, con ello evitamos eliminarlo y volver a crearlo.
--Vamos a agregar el campo "autor" al �ndice "I_libros_titulo" y vemos si se modific�:

 create index I_libros_titulo
 on libros(titulo,autor)
 with drop_existing

 exec sp_helpindex libros

--Lo convertimos en agrupado y ejecutamos "sp_helpindex":

 create clustered index I_libros_titulo
 on libros(titulo,autor)
 with drop_existing

 exec sp_helpindex libros

--Quitamos un campo "autor" y verificamos la modificaci�n:

 create clustered index I_libros_titulo
 on libros(titulo)
 with drop_existing

 exec sp_helpindex libros
 
 
 
--ELIMINACION DE INDICES
 
 
 --Eliminamos el �ndice "I_libros_titulo":

 drop index libros.I_libros_titulo

--Verificamos que se elimin�:

 sp_helpindex libros

--Solicitamos que se elimine el �ndice "I_libros_titulo" si existe:

 if exists (select name from sysindexes
  where name = 'I_libros_titulo')
   drop index libros.I_libros_titulo


 
 
 
 
