-- Funciones matemáticas

-- Una empresa almacena los datos de sus empleados en una tabla denominada "empleados".

-- Eliminamos la tabla:

  drop table empleados;
-- Creamos la tabla:

 create table empleados(
  legajo number(5),
  documento char(8) not null,
  nombre varchar2(30) not null,
  domicilio varchar2(30),
  sueldo number(6,2),
  hijos number(2),
  primary key (legajo)
 );
-- Ingresamos algunos registros:

 insert into empleados
  values(1,'22333444','Ana Acosta','Avellaneda 213',870.79,2);
 insert into empleados
  values(20,'27888999','Betina Bustos','Bulnes 345',950.85,1);
 insert into empleados
  values(31,'30111222','Carlos Caseres','Caseros 985',1190,0);
 insert into empleados
  values(39,'33444555','Daniel Duarte','Dominicana 345',1250.56,3);
-- Vamos a mostrar los sueldos de los empleados redondeando el valor hacia abajo y luego hacia arriba (empleamos "floor" y "ceil"):

 select floor(sueldo) as "sueldo hacia abajo",
  ceil(sueldo) as "sueldo hacia arriba"
  from empleados;
-- Mostramos los nombre de cada empleado, su respectivo sueldo, y el sueldo redondeando el valor a entero ("round") y truncado a entero ("trunc"):

 select nombre, sueldo, round(sueldo) as "sueldo redondeado",
  trunc(sueldo) as "sueldo truncado"
  from empleados;
-- Note que los valores devueltos según la función empleada, son diferentes.

-- Mostramos el resultado de "2 elevado a la potencia 5" ("power"):

 select power(2,5) from dual;
-- Retorna el valor 32.

-- Mostramos el resto de la división "1234 / 5" ("mod"):

 select mod(1234,5) from dual;
-- Devuelve el valor 4.

-- Calculamos la raíz cuadrada de 81:

 select sqrt(81) from dual;
-- Retorna 9.

-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table empleados;

 create table empleados(
  legajo number(5),
  documento char(8) not null,
  nombre varchar2(30) not null,
  domicilio varchar2(30),
  sueldo number(6,2),
  hijos number(2),
  primary key (legajo)
 );

 insert into empleados
  values(1,'22333444','Ana Acosta','Avellaneda 213',870.79,2);
 insert into empleados
  values(20,'27888999','Betina Bustos','Bulnes 345',950.85,1);
 insert into empleados
  values(31,'30111222','Carlos Caseres','Caseros 985',1190,0);
 insert into empleados
  values(39,'33444555','Daniel Duarte','Dominicana 345',1250.56,3);

 select floor(sueldo) as "sueldo hacia abajo",
  ceil(sueldo) as "sueldo hacia arriba"
  from empleados;

 select nombre, sueldo, round(sueldo) as "sueldo redondeado",
  trunc(sueldo) as "sueldo truncado"
  from empleados;

 select power(2,5) from dual;

 select mod(1234,5) from dual;

 select sqrt(81) from dual;