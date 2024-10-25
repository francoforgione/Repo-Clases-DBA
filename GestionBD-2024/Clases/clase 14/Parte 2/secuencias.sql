-- secuencias - create sequence - currval - nextval - drop sequence

-- Veamos las secuencias existentes:

 select *from all_sequences;
-- Aparece una tabla que nos muestra todas las secuencias; la columna "SEQUENCE_NAME" contiene el nombre de cada secuencia; las demás columnas nos informan sobre cada una de las secuencias de la base de datos actual (propietario, valores mínimo y máximo, valor de incremento, si es circular o no, etc.).

-- Vamos a crear una secuencia denominada "sec_codigolibros" para utilizarla en la clave primaria de la tabla "libros".

-- En primer lugar vamos a eliminar la secuencia "sec_codigolibros" porque si ya existe no podremos crear otra con el mismo nombre:

 drop sequence sec_codigolibros;
-- Si la secuencia no existe aparecerá un mensaje indicando tal situación.

-- Creamos la secuencia llamada "sec_codigolibros", estableciendo que comience en 1, sus valores estén entre 1 y 99999 y se incrementen en 1, por defecto, será "nocycle":

 create sequence sec_codigolibros
  start with 1
  increment by 1
  maxvalue 99999
  minvalue 1;
-- Para acceder a las secuencias (que son tablas) empleamos "select" y la tabla "dual".

-- En primer lugar, debemos inicializar la secuencia:

 select sec_codigolibros.nextval from dual;
-- Nos retorna el valor 1.

-- Recuperamos el valor actual de nuestra secuencia:

 select sec_codigolibros.currval from dual;
-- Retorna 1.

-- Eliminamos la tabla "libros" y la creamos con la siguiente estructura:

 drop table libros;
 create table libros(
  codigo number(5) not null,
  titulo varchar2(40) not null,
  autor varchar2(30),
  editorial varchar2(20),
  primary key(codigo)
 );
-- Note que al crear la tabla no se hace referencia en ningún momento a la secuencia que luego servirá para dar valores secuenciales a su clave primaria.

-- Ingresamos un registro en "libros", almacenando en el campo "codigo" el valor actual de la secuencia:

 insert into libros values
  (sec_codigolibros.currval,'El aleph', 'Borges','Emece');
-- Ingresamos otro registro en "libros", almacenando en el campo "codigo" el valor siguiente de la secuencia:

 insert into libros values
  (sec_codigolibros.nextval,'Matematica estas ahi', 'Paenza','Nuevo siglo');
-- Recuerde que "nextval" incrementa la secuencia y retorna el nuevo valor.

-- Recuperamos todos los registros para ver qué se ha almacenado en "codigo":

 select *from libros;
-- Veamos todos los objetos de la base de datos actual que contengan en su nombre la cadena "LIBROS":

 select object_name,object_type
  from all_objects
  where object_name like '%LIBROS%';
-- En la tabla resultado aparecen la tabla "libros" y la secuencia "sec_codigolibros".

-- Eliminamos la secuencia creada:

 drop sequence sec_codigolibros;
-- Un mensaje indica que la secuencia ha sido eliminada.

-- Si consultamos todos los objetos de la base de datos veremos que tal secuencia ya no existe:

 select object_name,object_type
  from all_objects
  where object_name like '%LIBROS%';
-- Ingresemos el siguiente lote de comandos en el Oracle SQL Developer:
 select *from all_sequences;

 drop sequence sec_codigolibros;

 create sequence sec_codigolibros
  start with 1
  increment by 1
  maxvalue 99999
  minvalue 1;

 select sec_codigolibros.nextval from dual;

 select sec_codigolibros.currval from dual;

 drop table libros;
 create table libros(
  codigo number(5) not null,
  titulo varchar2(40) not null,
  autor varchar2(30),
  editorial varchar2(20),
  primary key(codigo)
 );

 insert into libros values
  (sec_codigolibros.currval,'El aleph', 'Borges','Emece');

 insert into libros values
  (sec_codigolibros.nextval,'Matematica estas ahi', 'Paenza','Nuevo siglo');

 select *from libros;

 select object_name,object_type
  from all_objects
  where object_name like '%LIBROS%';

 drop sequence sec_codigolibros;

 select object_name,object_type
  from all_objects
  where object_name like '%LIBROS%';