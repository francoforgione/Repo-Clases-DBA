/*Ejercicios sobre Funciones*/

--A) Un instituto de enseñanza almacena los datos de sus estudiantes en una tabla llamada "alumnos".
create database funciones;
use funciones
--1- Elimine la tabla "alumnos" si existe.
DROP TABLE IF EXISTS alumnos;

--2- Cree la tabla con la siguiente estructura:
 create table alumnos(
  documento char(8) not null,
  nombre varchar(30),
  domicilio varchar(30),
  fechaNacimiento date,
  primary key (documento)
 );

--3- Ingrese los siguientes registros:
 insert into alumnos (documento,nombre,domicilio,fechaNacimiento)
  values('22345345','Mariana Perez','Colon 234','1986-10-08');
 insert into alumnos (documento,nombre,domicilio,fechaNacimiento)
  values('23545345','Marcos Morales','Avellaneda 348','1985-12-18');
 insert into alumnos (documento,nombre,domicilio,fechaNacimiento)
  values('24356345','Analia Gonzalez','Caseros 444','1976-06-28');
 insert into alumnos (documento,nombre,domicilio,fechaNacimiento)
  values('20254125','Ramiro Torres','Dinamarca 209','1978-01-28');
 insert into alumnos (documento,nombre,domicilio,fechaNacimiento)
  values('20445778','Carmen Miranda','Uspallata 999','1980-05-30');
 insert into alumnos (documento,nombre,domicilio,fechaNacimiento)
  values('28111444','Natalia Figueroa','Sarmiento 856','1986-04-29');
  
  select * from alumnos;

--4- El institulo quiere conocer las edades de los alumnos
 delimiter //
create function f_calcula_edad (nacimiento date)
  returns int
 begin 
   return datediff(year,nacimiento,getdate());
 end;
// delimiter ;


select datediff(day,getdate(),1995-04-19)

select getdate()

B) La empresa que provee de luz a los usuarios de un municipio la luz. Almacena en una tabla algunos datos de los usuarios:
- documento, cadena siempre de 8 caracteres, no nulo,
- monto a pagar, valor con decimales positivo,
- fecha de vencimiento.
Si la boleta no se paga hasta el día del vencimiento, inclusive, se incrementa al monto, un 1% del monto cada día de atraso.

1- Elimine la tabla, si existe.
2- Cree la tabla.
3- Ingrese algunos registros con fechas de vencimiento anterior a la fecha actual (vencidas) y posteriores a la fecha actual (no vencidas).
4- Muestre el documento del usuario, la fecha de vencimiento, la fecha actual (en que efectúa el pago), el monto, la cantidad de días de atraso (respecto de la fecha de vencimiento), el recargo y el total a pagar con el recargo:










C-) En una página web se solicitan los siguientes datos para guardar información de sus visitas: nombre, mail, pais.
1- Elimine la tabla "visitas", si existe.
2- Créela con la siguiente estructura:
 create table visitas (
  numero int unsigned auto_increment,
  nombre varchar(30) not null,
  mail varchar(50),
  pais varchar (20),
  fecha datetime,
  primary key(numero)
);

3- Ingrese algunos registros:
 insert into visitas (nombre,mail,fecha)
  values ('Ana Maria Lopez','AnaMaria@hotmail.com','2006-10-10 10:10');
 insert into visitas (nombre,mail,fecha)
  values ('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','2006-10-10 21:30');
 insert into visitas (nombre,mail,fecha)
  values ('Juancito','JuanJosePerez@hotmail.com','2006-10-11 15:45');
 insert into visitas (nombre,mail,fecha)
  values ('Fabiola Martinez','MartinezFabiola@hotmail.com','2006-10-12 08:15');
 insert into visitas (nombre,mail,fecha)
  values ('Fabiola Martinez','MartinezFabiola@hotmail.com','2006-09-12 20:45');
 insert into visitas (nombre,mail,fecha)
  values ('Juancito','JuanJosePerez@hotmail.com','2006-09-12 16:20');
 insert into visitas (nombre,mail,fecha)
  values ('Juancito','JuanJosePerez@hotmail.com','2006-09-15 16:25');

4- Se necesita el nombre de los usuarios y la hora de visita:
5- Se necesita conocer el nombre de los usuarios y el nombre del mes de cada visita:
6- Se necesita saber la cantidad de visitas por día (lunes, martes...), mostrando el nombre del día:
