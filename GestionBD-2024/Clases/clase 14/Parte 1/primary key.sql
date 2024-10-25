-- primary key

-- Trabajamos con la tabla "usuarios".

-- Eliminamos la tabla:

  drop table usuarios;
-- Creamos la tabla definiendo el campo "nombre" como clave primaria:

 create table usuarios(
  nombre varchar2(20),
  clave varchar2(10),
  primary key (nombre)
 );
-- Al campo "nombre" no lo definimos "not null", pero al establecerse como clave primaria, Oracle lo convierte en "not null", veamos que en la columna "NULL" aparece "NOT NULL":

 describe usuarios;
-- Ingresamos algunos registros:

 insert into usuarios (nombre, clave)
  values ('juanperez','Boca');
 insert into usuarios (nombre, clave)
  values ('raulgarcia','River');
-- Recordemos que cuando un campo es clave primaria, sus valores no se repiten. Intentamos ingresar un valor de clave primaria existente:

  insert into usuarios (nombre, clave)
  values ('juanperez','payaso');
-- aparece un mensaje de error y la sentencia no se ejecuta.

-- Cuando un campo es clave primaria, sus valores no pueden ser nulos. Intentamos ingresar el valor "null" en el campo clave primaria:

  insert into usuarios (nombre, clave)
  values (null,'payaso');
-- aparece un mensaje de error y la sentencia no se ejecuta.

-- Si realizamos alguna actualización, Oracle controla que los valores para el campo establecido como clave primaria no estén repetidos en la tabla. Intentemos actualizar el nombre de un usuario colocando un nombre existente:

  update usuarios set nombre='juanperez'
  where nombre='raulgarcia';
-- aparece un mensaje indicando que se viola la clave primaria y la actualización no se realiza.

-- Corroboramos que la tabla "usuarios" tiene establecido el campo "nombre" como clave primaria realizando la siguiente consulta (Recuerde colocar el nombre de la tabla en mayúsculas, sino Oracle considerará que no existe la tabla):

 select uc.table_name, column_name from user_cons_columns ucc
  join user_constraints uc
  on ucc.constraint_name=uc.constraint_name
  where uc.constraint_type='P' and
  uc.table_name='USUARIOS';
-- Aparece la siguiente tabla:

-- TABLE_NAME                     COLUMN_NAME
--------------------------------------------
-- USUARIOS                       NOMBRE
-- indicando que la tabla "usuarios" tiene establecido el campo "nombre" como clave primaria.

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table usuarios;

 create table usuarios(
  nombre varchar2(20),
  clave varchar2(10),
  primary key (nombre)
 );

 describe usuarios;

 insert into usuarios (nombre, clave)
  values ('juanperez','Boca');
 insert into usuarios (nombre, clave)
  values ('raulgarcia','River');

 insert into usuarios (nombre, clave)
  values ('juanperez','payaso');

 insert into usuarios (nombre, clave)
  values (null,'payaso');

 update usuarios set nombre='juanperez'
  where nombre='raulgarcia';

 select uc.table_name, column_name from user_cons_columns ucc
  join user_constraints uc
  on ucc.constraint_name=uc.constraint_name
  where uc.constraint_type='P' and
  uc.table_name='USUARIOS';