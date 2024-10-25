-- Funciones string

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
  cantidad number(3)
 );
-- Ingresamos algunos registros:

 insert into libros
   values(1,'El aleph','Borges','Emece',25,100);
 insert into libros
  values(2,'Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);
 insert into libros
  values(3,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',15.50,200);
 insert into libros
  values(4,'El pais de las hadas',default,'Emece',25.50,150);
-- Mostramos sólo los 12 primeros caracteres de los títulos de los libros y sus autores, empleando la función "substr":

 select substr(titulo,1,12) as titulo
  from libros;
-- Mostramos sólo los 20 primeros caracteres de los títulos de los libros y rellenando los espacios restantes con "*", empleando la función "rpad":

 select rpad(titulo,20,'*') as titulo
  from libros;
-- Mostramos los títulos de los libros empleando la función "initcap":

 select initcap(titulo) as titulo
  from libros;
-- Note que cada palabra comienza con mayúsculas.

-- Mostramos los títulos de los libros y sus autores en mayúsculas:

 select titulo,upper(autor) as autor
  from libros;
-- Concatenamos título y autor empleando "concat":

  select concat(titulo, autor)
   from libros;
-- Mostramos el título y el precio de todos los libros concatenando el signo "$" a los precios:

  select titulo,concat('$ ',precio) as precio
   from libros;
-- Recuperamos el título y editorial de "libros" reemplazando "Emece" por "Sudamericana":

  select titulo,replace(editorial,'Emece','Sudamericana')
   from libros;
-- Recuperamos el autor de todos los libros reemplazando las letras "abc" por "ABC" respectivamente (empleando "translate"):

 select translate(autor,'abc','ABC') from libros;
-- Note que cada caracter individual es reemplazado por el especificado.

-- Mostramos la posición de la primera ocurrencia de la cadena "pais" en los títulos de los libros:

 select instr(titulo,'pais') from libros;
-- Note que los títulos que no contienen la subcadena "pais" muestran el valor cero.

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  codigo number(5),
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  precio number(6,2),
  cantidad number(3)
 );

 insert into libros
   values(1,'El aleph','Borges','Emece',25,100);
 insert into libros
  values(2,'Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);
 insert into libros
  values(3,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',15.50,200);
 insert into libros
  values(4,'El pais de las hadas',default,'Emece',25.50,150);

 select substr(titulo,1,12) as titulo
  from libros;

 select rpad(titulo,20,'*') as titulo
  from libros;

 select initcap(titulo) as titulo
  from libros;

 select titulo,upper(autor) as autor
  from libros;

  select concat(titulo, autor)
   from libros;

  select titulo,concat('$ ',precio) as precio
   from libros;

  select titulo,replace(editorial,'Emece','Sudamericana')
   from libros;

 select translate(autor,'abc','ABC') from libros;

 select instr(titulo,'pais') from libros;