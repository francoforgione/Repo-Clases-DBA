-- Operaciones entre consultas
create database operaciones
go
use operaciones

create table A(pais char(20))
create table B(pais char(20))

insert into A values('Arg'),('Bra'),('Uru')
insert into B values('Arg'),('Col'),('Ven')

-- union
select pais from A
union
select pais from B
/*Arg
Bra
Col
Uru
Ven
*/

-- union all: repite la interseccion
select pais from A
union all
select pais from B
/*Arg
Bra
Col
Uru
Ven
*/

-- intersect:
select pais from A
intersect
select pais from B
/*
Arg
*/

-- except:
select pais from A
except
select pais from B
/*
Bra
Uru
*/

-- operaiones entre queries de mas de 1 columna 
use pubs

--Listar el libro y a ciudad donde fue escrito o publicado
select		t.title as libro,
			p.city as 'Ciudad Editorial',
			null 'Ciudad Autor'
from		titles t
inner join	publishers p
on			p.pub_id = t.pub_id

union

select		t.title as libro,
			null 'Ciudad Editorial',
			a.city as 'Ciudad Autor'
from		titles t
inner join	titleauthor ta
on			ta.title_id = t.title_id
inner join	authors a
on			a.au_id = ta.au_id

-- combinacion
select		t.title as libro,
			'Publicado en: ' + p.city as ciudad 
from		titles t
inner join	publishers p
on			p.pub_id = t.pub_id

union

select		t.title as libro,
			'Escrito en: ' + a.city ciudad
from		titles t
inner join	titleauthor ta
on			ta.title_id = t.title_id
inner join	authors a
on			a.au_id = ta.au_id

-- subconsultas == subselect = subquery = consultas anidadas
-- SELECT (E)
-- Listar el titulo, el precio y la diferencia de precios entre cada libro respecto del mas barato
select	title libro,
		price precio,
		price - (select min(price)from titles) as diferencia
from	titles

-- FROM (T)
-- Listar el titulo, el precio y la diferencia de precios entre cada libro respecto del mas barato
-- La diferencia debe ser mayor a cero.
SELECT  *
FROM	(
			select title libro,
				   price precio,
				   price - (select min(price) from titles) as diferencia
			from   titles
		) as miTabla
WHERE	miTabla.diferencia > 0
ORDER BY miTabla.diferencia desc

-- WHERE (E)
-- Listar los libros cuyo precio sea superior al precio promedio de todos los libros
select  *
from	titles
where	price > (
					select  avg(price)
					from	titles
				)

-- WHERE (L)
-- Listar las editoriales que hayan publicado libros de negocio
select	*
from	publishers
where	pub_id in	(
						select pub_id
						from   titles
						where  type like '%business%'
					)
