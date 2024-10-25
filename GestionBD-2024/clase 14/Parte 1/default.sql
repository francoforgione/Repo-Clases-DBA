-- default

-- Trabajamos con la tabla "libros" de una librería.

-- Eliminamos la tabla:

  drop table libros;
-- Creamos la tabla estableciendo valores por defecto para los campos "autor" y "cantidad":

 create table libros(
  titulo varchar2(40) not null,
  autor varchar2(30) default 'Desconocido' not null, 
  editorial varchar2(20),
  precio number(5,2),
  cantidad number(3) default 0
 );
-- Ingresamos un registro omitiendo los valores para el campo "autor" y "cantidad":

 insert into libros (titulo,editorial,precio)
  values('Java en 10 minutos','Paidos',50.40);
-- Oracle ingresará el registro con el título, editorial y precio especificados, en "autor" colocará "Desconocido" y en cantidad "0", veámoslo:

 select *from libros;
-- Si ingresamos un registro sin valor para el campo "precio", que admite valores nulos, se ingresará "null" en ese campo:

 insert into libros (titulo,editorial)
  values('Aprenda PHP','Siglo XXI');
-- Veamos cómo se almacenó el registro ingresado anteriormente:

 select *from libros;
-- Veamos si los campos de la tabla "libros" tiene definidos valores por defecto y cuáles son:

 select column_name,nullable,data_default
  from user_tab_columns where TABLE_NAME = 'LIBROS';
-- Muestra la siguiente tabla:

-- COLUMN_NAME	NULLABLE	DATA_DEFAULT
---------------------------------------------
-- TITULO		N
-- AUTOR		N		'Desconocido'
-- EDITORIAL	Y
-- PRECIO		Y
-- CANTIDAD	Y		0
-- Muestra una fila por cada campo, en la columna "data_default" aparece el valor por defecto (si lo tiene), en la columna "nullable" aparece "N" si el campo no está definido "not null" y "Y" si permite valores nulos.

-- Podemos emplear "default" para dar el valor por defecto a algunos campos al ingresar un registro:

 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El gato con botas',default,default,default,default);
-- Veamos cómo se almacenó el registro:

 select *from libros where titulo='El gato con botas';
-- Todos los campos, excepto "titulo" almacenaron su valor predeterminado.

-- Que un campo tenga valor por defecto no significa que no admita valores nulos, puede o no admitirlos. Podemos ingresar el valor "null" en el campo "cantidad":

 insert into libros (titulo,autor,cantidad)
  values ('Alicia en el pais de las maravillas','Lewis Carroll',null);
-- Recuperamos el registro ingresado anteriormente:

 select *from libros where autor='Lewis Carroll'; 
-- En "cantidad" se almacenó "null".

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  titulo varchar2(40) not null,
  autor varchar2(30) default 'Desconocido' not null, 
  editorial varchar2(20),
  precio number(5,2),
  cantidad number(3) default 0
 );

 insert into libros (titulo,editorial,precio)
  values('Java en 10 minutos','Paidos',50.40);

 select *from libros;

 insert into libros (titulo,editorial)
  values('Aprenda PHP','Siglo XXI');

 select *from libros;

 select column_name,nullable,data_default
  from user_tab_columns where TABLE_NAME = 'LIBROS';

 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El gato con botas',default,default,default,default);

 select *from libros where titulo='El gato con botas';

 insert into libros (titulo,autor,cantidad)
  values ('Alicia en el pais de las maravillas','Lewis Carroll',null);

 select *from libros where autor='Lewis Carroll'; 