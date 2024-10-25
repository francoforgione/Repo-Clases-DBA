

--PLAN DE EJECUCION SQL SERVER


--Cada vez que se ejecuta una consulta en un motor de bases de datos, internamente se
--ejecutan una serie de operaciones, que var�an seg�n la consulta, los datos y obvia
--mente, el motor de base de datos. El conjunto de pasos que tiene que realizarel mo
--tor para ejecutar la consulta, se llama Plan de Ejecuci�n. Hoy vamos a explicar c�mo
--entender el plan de Ejecuci�n de SQL Server. Que operaciones podemos encon
--trar en el plan de ejecuci�n?











--Table Scan:

--Significa que el motor tiene que leer toda la tabla. Esto solo puede suceder cuando 
--la tabla es Heap (o sea, no tiene un �ndice clustered). En algunos casos, cuando es 
--una tabla chica, un Table Scan es la mejor opci�n, ya que produce poco overhead. De 
--hecho la tabla puede tener �ndices y sin embargo el SQL elige usar un table scan por
--que ser�a m�s r�pido. Pero cuando la tabla es m�s grande, no deber�a haber Table Scan
--, ya que es muy costoso. Para solucionar este problema, hay ver si la tabla tiene �n
--dices y si se est�n usando correctamente. Lo importante es prestarle atenci�n cuando
--vemos un table Scan. Muchas veces, nuestro problemas de performance pasan por ah�.

--Ejemplo:

create database prueba
go
use prueba


CREATE TABLE [TablaPrueba1]
(
Campo1 int IDENTITY (1, 1) NOT NULL ,
Campo2 int,
Campo3 int,
Campo4 int,
Campo5 char (30)
)

SELECT * FROM TablaPrueba1


--EstimateCPU="7.96E-05" EstimateIO="0.0032035"

SET NOCOUNT ON--Evita que se devuelva el mensaje que muestra el recuento del n�mero de filas
--afectadas por una instrucci�n o un procedimiento almacenado de Transact-SQL como parte del
-- conjunto de resultados.
DECLARE @Top int
SET @Top = 0
WHILE @Top != 10000
	BEGIN
		INSERT INTO TablaPrueba1 VALUES (convert(int,rand()*20000),convert(int,rand()*20000),
		convert(int,rand()*20000), 'P')
		SET @Top = @Top+1
	END


SELECT * FROM TablaPrueba1
where Campo1= 500

--EstimateCPU="0.0110785" EstimateIO="0.0557961"

/*
EstimateCPU: Este valor indica el tiempo estimado que tardar� el procesador en ejecutar la consulta. En este caso, 0.0110785 representa 0.0110785 segundos. Si bien parece un valor peque�o, es importante considerarlo en conjunto con el contexto de la consulta y la carga del servidor.

EstimateIO: Este valor indica la cantidad estimada de datos que se leer�n y escribir�n en el disco durante la ejecuci�n de la consulta. En este caso, 0.0557961 representa 0.0557961 p�ginas de datos. Una p�gina de datos suele ser de 8KB, por lo que este valor indica que se leer�n y escribir�n aproximadamente 446 bytes de datos.

Estimated Operator Cost=0.06 representa el costo total estimado de la operaci�n en t�rminos de recursos computacionales. Es la suma de los costos estimados de CPU y E/S, junto con otros costos menores asociados con la operaci�n.

*/













--Clustered Index Scan:

--Esta operaci�n es muy similar a un table scan. El motor recorre toda la tabla. La  di
--ferencia entre uno y otro, es que el Clustered Index Scan se realiza en una tabla que
--tiene un �ndice Clustered y el Table Scan en una tabla que no tiene este tipo de indi
--ce.
--Otra vez tenemos que evaluar si esta opci�n es la que realmente queremos.Muchas veces,
--por un mal uso de los �ndices, se ejecuta esta operaci�n,cuando en realidad quer�amos
--otra m�s eficiente.

--Ejemplo de un Clustered Index Scan:

create TABLE [TablaPrueba2]
(
Campo1 int IDENTITY (1, 1) NOT NULL,
Campo2 int,
Campo3 int,
Campo4 int,
Campo5 char (30),
CONSTRAINT PK_Campo1 PRIMARY KEY clustered (Campo1)
)

SELECT * FROM TablaPrueba2

--EstimateCPU="0.0001581" EstimateIO="0.003125"

SET NOCOUNT ON
DECLARE @Top int
SET @Top = 0
WHILE @Top != 10000
	BEGIN
		INSERT INTO TablaPrueba2 VALUES (convert(int,rand()*20000),convert(int,rand()*20000),
		convert(int,rand()*20000), 'P')
		SET @Top = @Top+1
	END
	
	
SELECT * FROM TablaPrueba2
where Campo1= 500 


--EstimateCPU="0.0001581" EstimateIO="0.003125"












--Clustered Index Seek:

--Si vemos esta operaci�n, significa que el motor est� usando efectivamente el �ndice Cluste
--red de la tabla.

--Ejemplo de esta operaci�n:
--(Usamos la tabla creada en el ejemplo anterior con un �ndice Clustered, le insertamos 10000
--registros para que el motor prefiriera usar el �ndice antes que un scan y filtramos por el
--�ndice).

create TABLE [TablaPrueba3]
(
Campo1 int IDENTITY (1, 1) NOT NULL,
Campo2 int,
Campo3 int,
Campo4 int,
Campo5 char (30),
CONSTRAINT PK_Campo1b PRIMARY KEY clustered (Campo1)
)

SET NOCOUNT ON
DECLARE @Top int
SET @Top = 0
WHILE @Top != 10000
	BEGIN
		INSERT INTO TablaPrueba3 VALUES (convert(int,rand()*20000),convert(int,rand()*20000),
		convert(int,rand()*20000), 'P')
		SET @Top = @Top+1
	END
	
	

SELECT * FROM TablaPrueba3 WHERE Campo1 IN(2,4,6,8,9) 

--EstimateCPU="0.0001625" EstimateIO="0.003125"














--Index Seek:

--Es similar que el  Clustered.
--Index Seek, pero con la diferencia de que se usa un indice Non Clustered.(Creamos un �ndice
--Non Clustered sobre la tabla TablaPrueba3)

CREATE INDEX IDX_Campo3 ON TablaPrueba3(Campo3) ON [PRIMARY]

--DROP INDEX TablaPrueba3.IDX_Campo3 

SELECT Campo3 FROM TablaPrueba3 WHERE  Campo3 = 1200


--EstimateCPU="0.000158446" EstimateIO="0.003125"


















--Index Scan:


--Esta operaci�n se ejecuta cuando se lee el �ndice completo de una tabla. Es preferible  a  un 
--Table Scan, ya que obviamente leer un indice es mas chico que una tabla. Esta operaci�n puede
--ser s�ntoma de un mal uso del �ndice, aunque tambi�n puede ser que el motor haya seleccionado 
--que esta es la mejor operaci�n. Es muy com�n un Index Scan en un  join o  en  un  ORDER  BY o 
--GROUP BY.
--Usemos la tabla TablaPrueba3, creada en el ejemplo anterior:
--(Como no hay ning�n filtro, el motor debe leer toda la tabla. Sin embargo, al traer  solo  el 
--Campo2, que pertenece a un �ndice Non Clustered, en vez de hacer un Table Scan, es mas  optimo 
--hacer un Index Scan).



SELECT Campo3 FROM TablaPrueba3


--EstimateCPU="0.011157" EstimateIO="0.0157176"


















--Bookmark Lookup:


--Esta es una operaci�n muy importante. El Bookmark Lookup indica que  SQL Server  necesita  eje
--cutar un salto del puntero desde la p�gina de �ndice a la p�gina de datos de la tabla para  re
--cuperar los datos.  Esto  sucede siempre que tenemos un �ndice Non Clustered. Para evitar esta
--operaci�n, hay que limitar los campos que queremos traer en la consulta.

--Si el campo que vamos a extraer, esta fuera del �ndice, entonces se va a ejecutar esta  opera
--ci�n y no queda otra opci�n (para SQL Server 2000). Ac� reside la importancia de  evitar  los 
--SELECT * FROM.
 
--Veamos el siguiente ejemplo usando nuevamente la tabla TablaPrueba3, pero con la siguiente con
--sulta para SQL Server: Se trae todos los campos de la tabla, filtrando por un campo pertenecien
--te a un �ndice non clustered.

SELECT Campo2,Campo3 FROM TablaPrueba3 WHERE Campo3 = 500


--Una de las m�s interesantes nuevas caracter�sticas de SQL Server 2005, es la posibilidad  de 
--incorporar en la pagina final del �ndice (donde residen los valores), campos de la tabla que
--son externos al �ndice.

--Que significa que "externo al �ndice"?: Significa que el campo no es parte de la  estructura 
--del �ndice, que no va a ser utilizado por el motor a la hora de filtrar y buscar, pero sin 
--embargo, su contenido est� copiado a la estructura de la �ltima p�gina del �ndice. La ventaja
--de esto, es que le ahorra al motor del SQL, hacer el boorkmark lookup, operaci�n bastante 
--costosa. La desventaja, es que al hacer m�s grande el �ndice, entran menos registros por 
--p�gina, lo cual podr�a llevar a que se tengan que hacer mas operaciones de I/O. Por lo tanto,
--es necesario hacer una evaluaci�n de costo/beneficio, antes de incluir campos adicionales al
--�ndice.
















--Joins:

--Un join es la relaci�n entre 2 tablas. SQL tiene tres tipos de joins. Neested Loop Join, Merge
--Join y Hash Join. Dependiendo de las caracter�sticas de la consulta y de la cantidad de regis
--tros, el motor puede decidir uno u otro.
 
--Ninguno es peor o mejor. Todo depende de las caracter�sticas de la consulta y del volumen de 
--datos.

--Neested Loop Join: Suele ser generalmente el m�s frecuente.  Es  tambi�n  el  algoritmo  m�s 
--simple de todo. Este operador fisico es usado por el motor cuando tenemos un  join  entre  2
--tablas y la cantidad de registros es relativamente baja.  Tambien  aplica  con  cierto  tipo 
--de joins (cross joins por ejemplo).



--Merge Join: Otro de los tipos de join que existen. Generalmente se usa cuando las cantida
--des de registros a comparar son relativamente grandes y est�n ordenadas. Aun si no  est�n 
--ordenadas, el motor puede predecir que es m�s r�pido ordenar la tabla y  hacer  el  merge 
--join que hacer un Neested Loop Join. En muchas situaciones es frecuente ver que una consul
--ta anteriormente usaba Neested Loop Join y en alg�n momento paso a  usar  un  Merge  Join. 
--La raz�n de esto, es porque el volumen de datos aumento y por lo tanto, es mas optimo usar
--un Merge join.

--Hash Join: Otro tipo m�s de join que existe. Mientras que los Loop Joins trabajan bien para 
--conjuntos chicos de datos y los merge join para conjuntos moderados de datos, el hash  join 
--es especialmente �til en grandes conjuntos de datos, generalmente en datawarehouses.   Este 
--operador es mucho mas paralelizable y escalable. Tambi�n se usa  generalmente  cuando   las 
--tablas relacionadas no tienen �ndice en ninguna de los campos a comparar.  Hay  que  prestar 
--atenci�n si vemos este tipo de operaciones, ya que puede significar un mal uso de los �ndices.

--Sin embargo, los hash joins consumen mucha memoria y SQL Server tiene un l�mite en la canti
--dad de operaciones de este tipo que puede efectuar simult�neamente. Existen varios subtipos 
--de hash joins. 

--Ejemplo:
--(Se va a ejecutar exactamente la misma consulta con una tabla con 50 registros y con 2000 
--registros, para ver c�mo cambia en funci�n del volumen de datos, el tipo de operaci�n)

-- con 50 registros

DELETE  FROM TablaPrueba3


SET NOCOUNT ON
DECLARE @Top int
SET @Top = 0
WHILE @Top != 50
	BEGIN
		INSERT INTO TablaPrueba3 VALUES (convert(int,rand()*20000),convert(int,rand()*20000),
		convert(int,rand()*20000), 'P')
		SET @Top = @Top+1
	END
	
	
SELECT * FROM TablaPrueba3
	
	
SELECT T1.* FROM tablaprueba3 T1 INNER JOIN TablaPrueba3 T2 ON T2.Campo4 = T1.Campo1



-- con 2000 registros

DELETE  FROM TablaPrueba3


SET NOCOUNT ON
DECLARE @Top int
SET @Top = 0
WHILE @Top != 2000
	BEGIN
		INSERT INTO TablaPrueba3 VALUES (convert(int,rand()*20000),convert(int,rand()*20000),
		convert(int,rand()*20000), 'P')
		SET @Top = @Top+1
	END
	
	
SELECT * FROM TablaPrueba3
	
	
SELECT T1.* FROM tablaprueba3 T1 INNER JOIN TablaPrueba3 T2 ON T2.Campo4 = T1.Campo1






























