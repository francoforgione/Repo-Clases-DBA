-- Ingresar registros 

Vemos si la tabla "usuarios" existe:

 select *from all_tables;
-- Si existe la eliminamos:

 drop table usuarios;
-- Creamos una nueva tabla denominada "usuarios" con los siguientes campos:

 create table usuarios(
  nombre varchar2(30),
  clave varchar2(10)
 );
-- Veamos si tiene registros:

 select *from usuarios;
-- No tiene, la tabla aparece vacía, solamente vemos las columnas que muestran los nombres de sus campos.

-- Agregamos un registro a la tabla:

 insert into usuarios (nombre, clave)
  values ('Mariano','payaso');
-- Un mensaje indica que se ingreso una fila.

-- Veamos nuevamente los registros de la tabla "usuarios":

 select *from usuarios;
-- Aparece la siguiente tabla:

-- NOMBRE	CLAVE
-------------
-- Mariano	payaso
-- La tabla contiene un solo registro, el ingresado recientemente.

-- Ingresamos otro registro, esta vez cambiamos el orden de los campos:

 insert into usuarios (clave, nombre)
 values ('River','Juan');
-- Ingresamos los datos en un orden distinto al orden en que se nombran los campos, no aparece un mensaje de error y los datos se guardan de modo incorrecto:

 insert into usuarios (nombre,clave)
  values ('Boca','Luis');
-- Veamos cómo se almacenaron los datos:

 select *from usuarios;
-- Aparece la siguiente tabla:

-- NOMBRE	CLAVE
-------------
-- Mariano	payaso
-- Juan	River
-- Boca	Luis
-- La tabla tiene 3 registros. Note que la clave "Boca" se guardó en el campo "nombre" y el nombre de usuario "Luis" en el campo "clave".

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
select * from all_tables;

drop table usuarios;

create table usuarios(
  nombre varchar2(30),
  clave varchar2(10)
);

select * from usuarios;

insert into usuarios (nombre, clave)
  values ('Mariano','payaso');

select *from usuarios;

insert into usuarios (clave, nombre)
 values ('River','Juan');

insert into usuarios (nombre,clave)
  values ('Boca','Luis');

select * from usuarios;