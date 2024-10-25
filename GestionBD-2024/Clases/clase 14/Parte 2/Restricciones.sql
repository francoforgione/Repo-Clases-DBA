-- Restricciones

-- Trabajamos con la tabla "libros" de una librería.
-- Eliminamos la tabla:

  drop table libros;
-- La creamos e ingresamos algunos registros:

 create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(5,2)
 );

 insert into libros values (1,'Uno','Bach','Planeta',22);
 insert into libros values (2,'El quijote','Cervantes','Emece',15);
 insert into libros values (2,'Aprenda PHP','Mario Molina','Siglo XXI',-40);
-- Intentamos agregar una restricción "primary key" para asegurar que los códigos no se repitan, pero como ya tenemos almacenado registros que infringen la restricción, Oracle nos mostrará un mensaje de error:

 alter table libros
 add constraint PK_libros_codigo
 primary key (codigo);
-- Vamos a especificar que no haya comprobación de datos existentes agregando "disable" y "novalidate":

 alter table libros
 add constraint PK_libros_codigo
 primary key (codigo) disable novalidate;
-- Veamos lo que nos informa "user_constraints":

 select constraint_name, constraint_type, status, validated
  from user_constraints
  where table_name='LIBROS';
-- Aparece la siguiente tabla:

-- CONSTRAINT_NAME		CONSTRAINT_TYPE		STATUS		VALIDATED
--------------------------------------------------------------------------
-- PK_LIBROS_CODIGO	P			DISABLED	NOT VALIDATED
-- La columna "status" nos informa que está deshabilitada (Disabled).

-- Si ingresamos un registro con código existente, Oracle lo permite, porque la restricción está en estado "disabled":

 insert into libros values (2,'Momo','Michael Ende','Alfaragua',25);
-- Intentamos habilitar la restricción sin verificar los datos ya almacenados:

 alter table libros
  -- enable novalidate constraint PK_libros_codigo;
-- No lo permite, aun cuando especificamos que no valide los datos existentes, Oracle realiza la verificación igualmente.

-- Eliminamos los registros con clave duplicada:

 delete libros where titulo='El quijote';
 delete libros where titulo='Momo';
-- Ahora Oracle permite habilitar la restricción:

 alter table libros
  -- enable novalidate constraint PK_libros_codigo;
-- Si intentamos actualizar un registro repitiendo la clave primaria, Oracle no lo permite:

 insert into libros values (2,'Momo','Michael Ende','Alfaragua',25);
-- Veamos lo que nos informa "user_constraints":

 select constraint_name, constraint_type, status, validated
  from user_constraints
  where table_name='LIBROS';
-- Aparece la siguiente tabla:

-- CONSTRAINT_NAME		CONSTRAINT_TYPE		STATUS		VALIDATED
--------------------------------------------------------------------------
-- PK_LIBROS_CODIGO	P			ENABLED		NOT VALIDATED
-- Intentamos agregamos una restricción "check" que no permita valores negativos para el precio:

 alter table libros
 add constraint CK_libros_precio
 check(precio>=0);
-- Oracle no lo permite porque, por defecto, la opción es "validate" y existen precios que violan la restricción que intentamos establecer.

-- Agregamos la restricción especificando que no valide los datos almacenados:

 alter table libros
 add constraint CK_libros_precio
 check(precio>=0) novalidate;
-- Veamos el estado de la restricción de control:

 select constraint_type, status, validated
  from user_constraints
  where table_name='LIBROS' and
  constraint_name='CK_LIBROS_PRECIO';
-- El resultado es el siguiente:

-- CONSTRAINT_TYPE		STATUS		VALIDATED
-----------------------------------------------------
-- C			ENABLED		NOT VALIDATED
-- Si intentamos ingresar un valor negativo para el precio, aparecerá un mensaje de error, porque la restricción de control creada está habilitada:

 insert into libros values (3,'Momo','Michael Ende','Alfaragua',-25);
-- Deshabilitamos la restricción "CK_libros_precio":

 alter table libros
  disable constraint CK_libros_precio;
-- Veamos el estado actual:

 select constraint_type, status, validated
  from user_constraints
  where table_name='LIBROS' and
  constraint_name='CK_LIBROS_PRECIO';
-- Nos muestra que está deshabilitada y no valida los datos existentes.

-- Ahora si podemos ingresar el registro:

 insert into libros values (3,'Momo','Michael Ende','Alfaragua',-25);
-- Habilitamos la restricción para futuros ingresos pero no para los existentes:

 alter table libros
  enable novalidate constraint CK_libros_precio;
-- Note que Oracle lo permite, no valida los datos existentes, pero si fuera otro tipo de restricción, no lo permitiría.

-- Consultamos "user_constraints":

 select constraint_type, status, validated
  from user_constraints
  where table_name='LIBROS' and
  constraint_name='CK_LIBROS_PRECIO';
-- Nos muestra que está habilitada y no valida los datos existentes.

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table libros;

 create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(5,2)
 );

 insert into libros values (1,'Uno','Bach','Planeta',22);
 insert into libros values (2,'El quijote','Cervantes','Emece',15);
 insert into libros values (2,'Aprenda PHP','Mario Molina','Siglo XXI',-40);

 alter table libros
 add constraint PK_libros_codigo
 primary key (codigo);

 alter table libros
 add constraint PK_libros_codigo
 primary key (codigo) disable novalidate;

 select constraint_name, constraint_type, status, validated
  from user_constraints
  where table_name='LIBROS';

 insert into libros values (2,'Momo','Michael Ende','Alfaragua',25);

 alter table libros
  enable novalidate constraint PK_libros_codigo;

 delete libros where titulo='El quijote';
 delete libros where titulo='Momo';

 alter table libros
  enable novalidate constraint PK_libros_codigo;

 insert into libros values (2,'Momo','Michael Ende','Alfaragua',25);

 select constraint_name, constraint_type, status, validated
  from user_constraints
  where table_name='LIBROS';

 alter table libros
 add constraint CK_libros_precio
 check(precio>=0);

 alter table libros
 add constraint CK_libros_precio
 check(precio>=0) novalidate;

 select constraint_type, status, validated
  from user_constraints
  where table_name='LIBROS' and
  constraint_name='CK_LIBROS_PRECIO';

 insert into libros values (3,'Momo','Michael Ende','Alfaragua',-25);

 alter table libros
  disable constraint CK_libros_precio;

 select constraint_type, status, validated
  from user_constraints
  where table_name='LIBROS' and
  constraint_name='CK_LIBROS_PRECIO';

 insert into libros values (3,'Momo','Michael Ende','Alfaragua',-25);

 alter table libros
  enable novalidate constraint CK_libros_precio;

 select constraint_type, status, validated
  from user_constraints
  where table_name='LIBROS' and
  constraint_name='CK_LIBROS_PRECIO';