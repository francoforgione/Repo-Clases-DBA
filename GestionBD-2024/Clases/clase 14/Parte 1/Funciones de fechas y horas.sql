-- Funciones de fechas y horas

-- Trabajamos con la tabla "libros" de una librería.

-- Eliminamos la tabla:

  drop table libros;
-- Creamos la tabla:

 create table libros(
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  edicion date,
  precio number(6,2)
 );
-- Ingresamos algunos registros:

 insert into libros values('El aleph','Borges','Emece','10/10/1980',25.33);
 insert into libros values('Java en 10 minutos','Mario Molina','Siglo XXI','05/05/2000',50.65);
 insert into libros
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece','08/09/2000',19.95);
 insert into libros values('Aprenda PHP','Mario Molina','Siglo XXI','02/04/2000',45);
-- Mostramos el título del libro y el año de edición:

 select titulo, extract (year from edicion) from libros;
-- Mostramos el título del libro y el mes de edición:

 select titulo, extract (month from edicion) from libros;
-- Mostramos el título del libro y los años que tienen de editados:

 select titulo, extract(year from sysdate)-extract(year from edicion) as "años de editado"
  from libros;
-- Mostramos los títulos de los libros que se editaron en el año 2000:

 select titulo from libros
  where extract(year from edicion)=2000;
-- Calcule 3 meses luego de la fecha actual empleando ""add_months":

 select add_months(sysdate,3) from dual;
-- Muestre la fecha del primer martes desde la fecha actual:

 select next_day(sysdate,'martes') from dual;
-- Muestre la fecha que será 15 días después de "24/08/2018" empleando el operador "+":

  select to_date('24/08/2018')+15 from dual;
-- Retorna 08/09/18.

-- Muestre la fecha que 20 días antes del "12/08/2018" empleando el operador "-":

  select to_date('12/08/2018')-20 from dual;
-- Retorna 23/07/18.

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  edicion date,
  precio number(6,2)
 );

 insert into libros values('El aleph','Borges','Emece','10/10/1980',25.33);
 insert into libros values('Java en 10 minutos','Mario Molina','Siglo XXI','05/05/2000',50.65);
 insert into libros
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece','08/09/2000',19.95);
 insert into libros values('Aprenda PHP','Mario Molina','Siglo XXI','02/04/2000',45);

 select titulo, extract (year from edicion) from libros;

 select titulo, extract (month from edicion) from libros;

 select titulo, extract(year from sysdate)-extract(year from edicion) as "años de editado"
  from libros;

 select titulo from libros
  where extract(year from edicion)=2000;

 select add_months(sysdate,3) from dual;

 select next_day(sysdate,'martes') from dual;

 select to_date('24/08/2018')+15 from dual;

 select to_date('12/08/2018')-20 from dual;