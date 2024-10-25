-- Clave primaria compuesta

-- Una playa de estacionamiento almacena cada día los datos de los vehículos que ingresan en la tabla llamada "vehiculos".

-- Seteamos el formato de "date" para que nos muestre únicamente la hora y los minutos, ya que en esta playa, se almacenan los datos de los vehículos diariamente:

 ALTER SESSION SET NLS_DATE_FORMAT = 'HH24:MI';
-- Eliminamos la tabla:

  drop table vehiculos;
-- Creamos la tabla estableciendo dos campos como clave primaria:

 create table vehiculos(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada date,
  horasalida date,
  primary key(patente,horallegada)
 );
-- Ingresamos algunos registros:

 insert into vehiculos values('AIC124','a','8:05','12:30');
 insert into vehiculos values('CAA258','a','8:05',null);
 insert into vehiculos values('DSE367','m','8:30','18:00');
 insert into vehiculos values('FGT458','a','9:00',null);
 insert into vehiculos values('AIC124','a','16:00',null);
 insert into vehiculos values('LOI587','m','18:05','19:55');
-- Si intentamos ingresar un registro con clave primaria repetida:

 insert into vehiculos values('LOI587','m','18:05',null);
-- aparece un mensaje de error y la inserción no se realiza.

-- Si ingresamos un registro repitiendo el valor de uno de los campos que forman parte de la clave, si lo acepta:

 insert into vehiculos values('LOI587','m','21:30',null);
-- Recuperamos todos los registros:

 select *from vehiculos;
-- Note que cada registro es único, dos de ellos tienen la misma patente, pero diferente hora de llegada.

-- Si intentamos actualizar un registro repitiendo la clave primaria:

 update vehiculos set horallegada='8:05'
  where patente='AIC124' and horallegada='16:00';
-- aparece un mensaje de error y la actualización no se realiza.

-- Recordemos que los campos que forman parte de la clave primaria no aceptan valores nulos, aunque no se haya aclarado en la definición de la tabla:

 insert into vehiculos values('HUO690','m',null,null);
-- Si mostramos la estructura de la tabla:

 describe vehiculos;
-- vemos que los campos que forman parte de la clave primaria (patente y horallegada) tienen "NOT NULL" en la columna "Null", es decir, no admiten valores nulos.

-- Para ver la clave primaria de una tabla podemos realizar la siguiente consulta:

 select uc.table_name, column_name, position from user_cons_columns ucc
  join user_constraints uc
  on ucc.constraint_name=uc.constraint_name
  where uc.constraint_type='P' and
  uc.table_name='VEHICULOS';
-- Nos retorna la siguiente información:

-- TABLE_NAME	COLUMN_NAME	POSITION
----------------------------------------
-- VEHICULOS	PATENTE		1
-- VEHICULOS	HORALLEGADA	2
-- Los dos campos son clave primaria, "POSITION" indica el orden en que fueron definidos los campos.

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 ALTER SESSION SET NLS_DATE_FORMAT = 'HH24:MI';

 drop table vehiculos;

 create table vehiculos(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada date,
  horasalida date,
  primary key(patente,horallegada)
 );

 insert into vehiculos values('AIC124','a','8:05','12:30');
 insert into vehiculos values('CAA258','a','8:05',null);
 insert into vehiculos values('DSE367','m','8:30','18:00');
 insert into vehiculos values('FGT458','a','9:00',null);
 insert into vehiculos values('AIC124','a','16:00',null);
 insert into vehiculos values('LOI587','m','18:05','19:55');

 insert into vehiculos values('LOI587','m','18:05',null);

 insert into vehiculos values('LOI587','m','21:30',null);

 select *from vehiculos;

 update vehiculos set horallegada='8:05'
  where patente='AIC124' and horallegada='16:00';

 insert into vehiculos values('HUO690','m',null,null);

 describe vehiculos;

 select uc.table_name, column_name, position from user_cons_columns ucc
  join user_constraints uc
  on ucc.constraint_name=uc.constraint_name
  where uc.constraint_type='P' and
  uc.table_name='VEHICULOS';