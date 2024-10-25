-- Una librería almacena los datos de sus libros en una tabla denominada "libros" y en otra tabla 
-- llamada "ventas", las ventas de los mismos.

-- Borramos las tablas "libros" y "ventas" si existen:

drop table if exists ventas;
drop table if exists libros;

-- Creamos las dos tablas con las siguientes estructuras:

 create table libros(
  codigo int auto_increment,
  titulo varchar(50),
  autor varchar(50),
  editorial varchar(30),
  precio float, 
  stock int,
  primary key (codigo)
 );

 create table ventas(
  numero int auto_increment,
  codigolibro int,
  precio float,
  cantidad int,
  primary key (numero)
 );

-- Insertamos algunas filas de prueba en la tabla "libros":

 insert into libros(titulo, autor, editorial, precio, stock)
  values('Uno','Richard Bach','Planeta',15,100);   
 insert into libros(titulo, autor, editorial, precio, stock)
  values('Ilusiones','Richard Bach','Planeta',18,50);
 insert into libros(titulo, autor, editorial, precio, stock)
  values('El aleph','Borges','Emece',25,200);
 insert into libros(titulo, autor, editorial, precio, stock)
  values('Aprenda PHP','Mario Molina','Emece',45,200);
  
  select * from libros;
  select * from ventas;

-- Del concepto anterior creamos nuevamente el disparador cuando se produce una 
-- venta para disminuir el stock de libros:

 drop trigger if exists before_ventas_insert;  

 delimiter //
 create trigger before_ventas_insert
   before insert
   on ventas
   for each row
 begin
   update libros set stock=libros.stock-new.cantidad
     where new.codigolibro=libros.codigo; 
 end //
 delimiter ;

-- Creamos un nuevo disparador para actualizar el campo "stock" de la tabla "libros"
-- cuando se elimina un registro de la tabla "ventas" (por ejemplo, si el comprador 
-- devuelve el o los libros comprados):

 drop trigger if exists before_ventas_delete;  
  
 delimiter //
 create trigger before_ventas_delete
   before delete
   on ventas
   for each row
 begin
  update libros set stock=libros.stock+old.cantidad
     where old.codigolibro=libros.codigo;   
 end //
 delimiter ;

-- Procedemos a efectuar una venta y luego controlar que se ha reducido en 1 el 
-- stock de dicho libro en la tabla 'libros':

 insert into ventas(codigolibro, precio, cantidad) values(1, 15, 1);

 select * from libros; 

-- Finalmente eliminamos la fila de la tabla 'ventas' por la devolución del libro, 
-- nuevamente podemos ver que gracias a la ejecución del trigger 
-- 'before_ventas_delete' se ha incrementado el stock en la tabla 'libros':

 delete from ventas where numero=1;
 
 select * from libros;