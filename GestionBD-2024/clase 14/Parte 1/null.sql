-- null

-- Trabajamos con la tabla "libros" de una librería.

-- Eliminamos la tabla "libros":

  drop table libros;
-- Creamos la tabla especificando que los campos "titulo" y "autor" no admitan valores nulos:

 create table libros(
  titulo varchar2(30) not null,
  autor varchar2(30) not null,
  editorial varchar2(15) null,
  precio number(5,2)
 );
-- Los campos "editorial" y "precio" si permiten valores nulos; el primero, porque lo especificamos colocando "null" en la definición del campo, el segundo lo asume por defecto.

-- Agregamos un registro a la tabla con valor nulo para el campo "precio":

 insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',null);
-- Veamos cómo se almacenó el registro:

 select *from libros;
-- No aparece ningún valor en la columna "precio".

-- Ingresamos otro registro, con valor nulo para el campo "editorial", campo que admite valores "null":

 insert into libros (titulo,autor,editorial,precio)
  values('Alicia en el pais','Lewis Carroll',null,0);
-- Veamos cómo se almacenó el registro:

 select *from libros;
-- No aparece ningún valor en la columna "editorial".

-- Ingresamos otro registro, con valor nulo para los dos campos que lo admiten:

 insert into libros (titulo,autor,editorial,precio)
  values('Aprenda PHP','Mario Molina',null,null);
-- Veamos cómo se almacenó el registro:

 select *from libros;
-- No aparece ningún valor en ambas columnas.

-- Veamos lo que sucede si intentamos ingresar el valor "null" en campos que no lo admiten, como "titulo":

 insert into libros (titulo,autor,editorial,precio)
  values(null,'Borges','Siglo XXI',25);
-- aparece un mensaje indicando que no se puede realizar una inserción "null" y la sentencia no se ejecuta.

-- Para ver cuáles campos admiten valores nulos y cuáles no, vemos la estructura de la tabla:

 describe libros;
-- nos muestra, en la columna "Null", que los campos "titulo" y "autor" están definidos "not null", es decir, no permiten valores nulos, los otros dos campos si los admiten.

-- Dijimos que la cadena vacía es interpretada como valor "null". Vamos a ingresar un registro con cadena vacía para el campo "editorial":

 insert into libros (titulo,autor,editorial,precio)
  values('Uno','Richard Bach','',18.50);
-- Veamos cómo se almacenó el registro:

 select *from libros;
-- No aparece ningún valor en la columna "editorial" del libro "Uno", almacenó "null".

-- Intentamos ingresar una cadena vacía en el campo "titulo":

 insert into libros (titulo,autor,editorial,precio)
  values('','Richard Bach','Planeta',22);
-- Mensaje de error indicando que el campo no admite valores nulos.

-- Dijimos que una cadena de espacios NO es igual a una cadena vacía o valor "null". Vamos a ingresar un registro y en el campo "editorial" guardaremos una cadena de 3 espacios:

insert into libros (titulo,autor,editorial,precio)
  values('Don quijote','Cervantes','   ',20);
-- Veamos cómo se almacenó el registro:

 select *from libros;
-- Se muestra la cadena de espacios.

-- Recuperamos los registros que contengan en el campo "editorial" una cadena de 3 espacios:

 select *from libros where editorial='   ';
-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  titulo varchar2(30) not null,
  autor varchar2(30) not null,
  editorial varchar2(15) null,
  precio number(5,2)
 );

 insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',null);

 select *from libros;

 insert into libros (titulo,autor,editorial,precio)
  values('Alicia en el pais','Lewis Carroll',null,0);

 select *from libros;

 insert into libros (titulo,autor,editorial,precio)
  values('Aprenda PHP','Mario Molina',null,null);

 select *from libros;

 insert into libros (titulo,autor,editorial,precio)
  values(null,'Borges','Siglo XXI',25);

 describe libros;

 insert into libros (titulo,autor,editorial,precio)
  values('Uno','Richard Bach','',18.50);

 select *from libros;

 insert into libros (titulo,autor,editorial,precio)
  values('','Richard Bach','Planeta',22);

insert into libros (titulo,autor,editorial,precio)
  values('Don quijote','Cervantes','   ',20);

 select *from libros;

 select *from libros where editorial='   ';