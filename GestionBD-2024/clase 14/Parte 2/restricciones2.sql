-- Restricciones2

-- Trabajamos con la tabla "libros" de una librería.
-- Eliminamos la tabla:

  drop table libros;
-- La creamos estableciendo el campo código como clave primaria:

 create table libros(
  codigo number(5) not null,
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(6,2)
 );
-- Definimos una restricción "primary key" para nuestra tabla "libros" para asegurarnos que cada libro tendrá un código diferente y único:

 alter table libros
 add constraint PK_libros_codigo
 primary key(codigo);
-- Definimos una restricción "check" para asegurarnos que el precio no será negativo:

 alter table libros
 add constraint CK_libros_precio
 check (precio>=0);
-- Definimos una restricción "unique" para los campos "titulo", "autor" y "editorial":

 alter table libros
 add constraint UQ_libros
 unique(titulo,autor,editorial);
-- Vemos las restricciones:

 select *from user_constraints where table_name='LIBROS';
-- Aparecen 4 restricciones:

-- - 1 "check" que controla que el precio sea positivo;

-- - 1 "check" , que se creó al definir "not null" el campo "codigo", el nombre le fue dado por Oracle;

-- - 1 "primary key" y

-- - 1 "unique".

-- Eliminamos la restricción "PK_libros_codigo":

 alter table libros
  drop constraint PK_LIBROS_CODIGO;
-- Eliminamos la restricción de control "CK_libros_precio":

 alter table libros
  drop constraint CK_LIBROS_PRECIO;
-- Vemos si se eliminaron:

 select *from user_constraints where table_name='LIBROS';
-- Aparecen 2 restricciones.

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  codigo number(5) not null,
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(6,2)
 );

 alter table libros
 add constraint PK_libros_codigo
 primary key(codigo);

 alter table libros
 add constraint CK_libros_precio
 check (precio>=0);

 alter table libros
 add constraint UQ_libros
 unique(titulo,autor,editorial);

 select *from user_constraints where table_name='LIBROS';

 alter table libros
  drop constraint PK_LIBROS_CODIGO;

 alter table libros
  drop constraint CK_LIBROS_PRECIO;

 select *from user_constraints where table_name='LIBROS';