-- Tipos de datos alfanuméricos

-- Un comercio que tiene un stand en una feria registra en una tabla llamada "visitantes" algunos datos de las personas que visitan o compran en su stand para luego enviarle publicidad de sus productos.

-- Eliminamos la tabla "visitantes":

  drop table visitantes;
-- Creamos con la siguiente estructura:

 create table visitantes(
  nombre varchar2(30),
  edad number(2),
  sexo char(1),
  domicilio varchar2(30),
  ciudad varchar2(20),
  telefono varchar2(11)
 );
-- Los campos "nombre", "domicilio" y "ciudad" almacenarán valores cuya longitud varía, por ello elegimos el tipo "varchar2" y le damos a cada uno una longitud máxima estimando su tamaño. El campo "sexo" se define de tipo "char", porque necesitamos solamente 1 caracter "f" o "m", que siempre será fijo. El campo "telefono" también se define como varchar2 porque no todos los números telefónicos tienen la misma longitud.

-- Ingresamos un registro:

 insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono)
  values ('Ana Acosta',25,'f','Avellaneda 123','Cordoba','4223344');
-- Intentamos ingresar una cadena de mayor longitud que la definida en el campo "sexo":

 insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono)
  values ('Betina Bustos',32,'fem','Bulnes 234','Cordoba','4515151');
-- aparece un mensaje de error y la sentencia no se ejecuta.

-- Ingresamos el mismo registro, esta vez con un sólo caracter para el campo "sexo":

 insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono)
  values ('Betina Bustos',32,'f','Bulnes 234','Cordoba','4515151');
-- Ingresamos un número telefónico olvidando las comillas, es decir, como un valor numérico:

 insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono)
  values ('Carlos Caseres',43,'m','Colon 345','Cordoba',03514555666);
-- lo convierte a cadena, veámoslo:

 select *from visitantes;
-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 drop table visitantes;

 create table visitantes(
  nombre varchar2(30),
  edad number(2),
  sexo char(1),
  domicilio varchar2(30),
  ciudad varchar2(20),
  telefono varchar2(11)
 );

 insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono)
  values ('Ana Acosta',25,'f','Avellaneda 123','Cordoba','4223344');

 insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono)
  values ('Betina Bustos',32,'fem','Bulnes 234','Cordoba','4515151');

 insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono)
  values ('Betina Bustos',32,'f','Bulnes 234','Cordoba','4515151');

 insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono)
  values ('Carlos Caseres',43,'m','Colon 345','Cordoba',03514555666);

 select *from visitantes;

 