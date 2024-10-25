-- Operadores lógicos

-- Trabajamos con la tabla "libros" de una librería.

-- Eliminamos la tabla y la creamos:

 drop table libros;

 create table libros(
  codigo number(5),
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  precio number(6,2)
 );
-- Ingresamos algunos registros:

 insert into libros
  values(1,'El aleph','Borges','Emece',15.90);
 insert into libros
  values(2,'Antología poética','Borges','Planeta',39.50);
 insert into libros
  values(3,'Java en 10 minutos','Mario Molina','Planeta',50.50);
 insert into libros
  values(4,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',19.90);
 insert into libros
  values(5,'Martin Fierro','Jose Hernandez','Emece',25.90);
 insert into libros
  values(6,'Martin Fierro','Jose Hernandez','Paidos',16.80);
 insert into libros
  values(7,'Aprenda PHP','Mario Molina','Emece',19.50);
 insert into libros
  values(8,'Cervantes y el quijote','Borges','Paidos',18.40);
-- Recuperamos los libros cuyo autor sea igual a "Borges" y cuyo precio no supere los 20 pesos:

 select *from libros
  where (autor='Borges') and
  (precio<=20);
-- Aparecen 2 libros, los únicos que cumplen con ambas condiciones.

-- Seleccionamos los libros cuyo autor es "Borges" y/o cuya editorial es "Planeta":

 select *from libros
  where autor='Borges' or
  editorial='Planeta';
-- Note que aparecen todos los libros de "Borges" y todos los libros de "Planeta", algunos cumplen ambas condiciones.

-- Recuperamos los libros cuya editorial NO es "Planeta":

 select *from libros
  where not editorial='Planeta';
-- Veamos un ejemplo de cómo el empleo de paréntesis permite a Oracle evaluar en forma diferente ciertas consultas aparentemente iguales:

 select *from libros
  where (autor='Borges') or
  (editorial='Paidos' and precio<20);

 select *from libros
  where (autor='Borges' or editorial='Paidos') and
  (precio<20);
-- Note que el primer resultado retorna todos los libros de "Borges" (primera condición) y todos los libros de "Paidos" con precio inferior a 20 (segunda condición) (registros 1,2,6 y 8); la segunda recupera todos los libros de "Borges" o de "Paidos" (primera condición) cuyo precio sea inferior a 20 (segunda condición) (registros 1,6 y 8).

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  codigo number(5),
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  precio number(6,2)
 );

 insert into libros
  values(1,'El aleph','Borges','Emece',15.90);
 insert into libros
  values(2,'Antología poética','Borges','Planeta',39.50);
 insert into libros
  values(3,'Java en 10 minutos','Mario Molina','Planeta',50.50);
 insert into libros
  values(4,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',19.90);
 insert into libros
  values(5,'Martin Fierro','Jose Hernandez','Emece',25.90);
 insert into libros
  values(6,'Martin Fierro','Jose Hernandez','Paidos',16.80);
 insert into libros
  values(7,'Aprenda PHP','Mario Molina','Emece',19.50);
 insert into libros
  values(8,'Cervantes y el quijote','Borges','Paidos',18.40);

 select *from libros
  where (autor='Borges') and
  (precio<=20);

 select *from libros
  where autor='Borges' or
  editorial='Planeta';

 select *from libros
  where not editorial='Planeta';

 select *from libros
  where (autor='Borges') or
  (editorial='Paidos' and precio<20);

 select *from libros
  where (autor='Borges' or editorial='Paidos') and
  (precio<20);