/*Ejercicio Propuesto:

Un club dicta cursos de distintos deportes. Almacena la información en varias tablas.
El director no quiere que los empleados de administración conozcan la estructura de las tablas ni 
algunos datos de los profesores y socios, por ello se crean vistas a las cuales tendrán acceso.*/

--1 - Elimine las tablas y créelas nuevamente:
 drop table if exists inscriptos;
 drop table if exists socios;
 drop table if exists profesores; 
 drop table if exists cursos;

 create table socios(
  documento char(8) not null,
  nombre varchar(40),
  domicilio varchar(30),
  primary key (documento)
 );

 create table profesores(
  documento char(8) not null,
  nombre varchar(40),
  domicilio varchar(30),
  primary key (documento)
 );

 create table cursos(
  numero integer identity,
  deporte varchar(20),
  dia varchar(15),
  documentoprofesor char(8),
  primary key (numero)
 );

 create table inscriptos(
  documentosocio char(8) not null,
  numero integer not null,
  matricula char(1),
  primary key (documentosocio,numero)
 );


--2- Ingrese algunos registros para todas las tablas:
 insert into socios values('30000000','Fabian Fuentes','Caseros 987');
 insert into socios values('31111111','Gaston Garcia','Guemes 65');
 insert into socios values('32222222','Hector Huerta','Sucre 534');
 insert into socios values('33333333','Ines Irala','Bulnes 345');

 insert into profesores values('22222222','Ana Acosta','Avellaneda 231');
 insert into profesores values('23333333','Carlos Caseres','Colon 245');
 insert into profesores values('24444444','Daniel Duarte','Sarmiento 987');
 insert into profesores values('25555555','Esteban Lopez','Sucre 1204');


 insert into cursos(deporte,dia,documentoprofesor) 
  values('tenis','lunes','22222222');
 insert into cursos(deporte,dia,documentoprofesor) 
  values('tenis','martes','22222222');
 insert into cursos(deporte,dia,documentoprofesor) 
  values('natacion','miercoles','22222222');
 insert into cursos(deporte,dia,documentoprofesor) 
  values('natacion','jueves','23333333');
 insert into cursos(deporte,dia,documentoprofesor) 
  values('natacion','viernes','23333333');
 insert into cursos(deporte,dia,documentoprofesor) 
  values('futbol','sabado','24444444');
 insert into cursos(deporte,dia,documentoprofesor) 
  values('futbol','lunes','24444444');
 insert into cursos(deporte,dia,documentoprofesor) 
  values('basquet','martes','24444444');

 insert into inscriptos values('30000000',1,'s');
 insert into inscriptos values('30000000',3,'n');
 insert into inscriptos values('30000000',6,null);
 insert into inscriptos values('31111111',1,'s');
 insert into inscriptos values('31111111',4,'s');
 insert into inscriptos values('32222222',8,'s');


--3- Elimine la vista "vista_club" si existe:
 drop view if exists vista_club;
--4 - Cree una vista en la que aparezca el nombre y documento del socio, el deporte, el día y el nombre del profesor (no mostrar datos de los socios que no están inscriptos en deportes)
create view vista_club  as
select a.nombre nombre_socio ,a.documento numero_documento_socio,c.deporte deporte, c.dia ,p.nombre nombre_profesor
from socios a
join inscriptos b
on a.documento = b.documentosocio
join cursos c
on c.numero = b.numero
join profesores p
on c.documentoprofesor = p.documento;


--5- Muestre la información contenida en la vista.
select * from vista_club

select * from inscriptos
--6- Realice una consulta a la vista donde muestre la cantidad de socios inscriptos en cada deporte ordenados por cantidad.
select deporte, count(*) from vista_club 
group by deporte
order by 2 desc

--7- Muestre (consultando la vista) el nombre y documento de los socios que deben matrículas.
select nombre_socio,numero_documento_socio, b.matricula 
from vista_club a
inner join inscriptos b
on a.numero_documento_socio = b.documentosocio
inner join cursos c 
on c.numero = b.numero
and a.deporte = c.deporte

--8- Consulte la vista y muestre los nombres de los profesores y los días en que asisten al club para dictar sus clases.
select nombre_profesor, dia from vista_club

--9- Muestre todos los socios que son compañeros en tenis los lunes.
select nombre_socio from vista_club
where dia = 'lunes'
and deporte = 'tenis'

--10 - Cree una nueva vista llamada 'vista_inscriptos' que muestre la cantidad de inscriptos por curso, incluyendo el nombre del deporte y el día.(Elimine la vista previamente si ya existe)
 drop view if exists vista_inscriptos;

create view vista_inscriptos as (
select c.deporte deporte, c.dia , count(distinct b.documentosocio) cantidad_inscriptos
from  inscriptos b
join cursos c
on c.numero = b.numero
group by c.deporte , c.dia  );

--11- Consulte la vista 'vista_inscriptos':
select * from vista_inscriptos

