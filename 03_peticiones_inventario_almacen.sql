-- ========================================================================

-- AUTOR:    		Sánchez Lugo Eduardo Alejandro.
-- FECHA:			27/O5/2026
-- DB: 		 		Librería.
-- MOTOR:           POSTGRESQL.
-- DESCRIPCIÓN:  	Consultas del área de almace.
-- VERSIÓN          1.0

-- ===============================================================================================
-- HISTORIAL:
-- 27/05/2026  Eduardo Sánchez  Versión inicial con Caso 1.
-- 27/05/2026  Juan Pérez       Se agregó la consulta para el Caso 2 (reabastecimiento).
-- 28/05/2026  Eduardo Sánchez  Se agregan dos consultas mas  stock promedio y consto inventario.
-- 30/05/2026  Eduardo Sánchez  Se agregan tres consultas: 5,6 y 7
-- 11/06/2026  Eduardo Sánchez  Se agregan tres consultas: 8 y 9.

-- ===============================================================================================


-- CASO 1	
-- =======================================================================================================
-- El jefe de almacén necesita un reporte diario que muestre, para cada libro, el valor monetario
-- actual en stock(precio x stock). Solo quiere los 10 libros con mayor valor invertido en inventario,
-- ordenados de mayor a menor.
-- =======================================================================================================


SELECT 
	titulo, 
	precio, 
	stock,
	(precio * stock) AS precio_total_inventario 	
FROM bookify.libros
ORDER BY precio_total_inventario DESC 
LIMIT 10;


-- CASO 2	
-- =======================================================================================================
-- El sistema de reabastecimiento automático debe calcular cuántas unidades faltan para llegar a un stock
-- de 100 unidades en cada libro. Muestra solo aquellos libros que tengan stock actual menor a 100.
-- =======================================================================================================


SELECT 
	titulo,
	stock,
	(100 - stock) AS  faltantes_100
FROM bookify.libros
WHERE stock < 100;


-- CASO 3
-- ==========================================================================================================
-- El equipo de planeación quiere saber el stock promedio de todos los libros en la librería. También quiere 
-- saber cuántos libros están por encima de ese promedio y cuántos por debajo (esto último puedes hacerlo 
-- con dos consultas o una condicional). 
-- ==========================================================================================================


SELECT 
	ROUND(AVG(stock),2) AS stock_promedio_todos_libros
FROM bookify.libros;

SELECT 
	CASE
		WHEN stock > 44.71 THEN 'Encima del promedio'
		ELSE 'Abajo del promedio'
	END AS estado_stock,
	COUNT(*) AS cantidad_libros
FROM bookify.libros
GROUP BY estado_stock;



-- CASO 4
-- ==========================================================================================================
-- El departamento de compras pregunta: si todos los libros costaran exactamente $350.00 MXN, 
-- ¿cuánto valdría todo el inventario actual? 
-- ==========================================================================================================


SELECT
	SUM((stock) * 350) AS valor_total_350
FROM  bookify.libros;




-- CASO 5
-- ==========================================================================================================
-- El gerente de compras quiere saber el precio promedio de los libros por categoría, pero solo de aquellas
-- categorías cuyo precio promedio sea mayor a $20. El resultado debe mostrarse con dos decimales. 
-- Muestra el nombre de la categoría y  el precio promedio.
-- ==========================================================================================================

SELECT 
	categoria_id,
	ROUND(AVG(precio),2) AS precio_promedio
FROM
	bookify.libros
GROUP BY
	categoria_id
HAVING 
	AVG(precio) > 20;


-- CASO 6
-- ==========================================================================================================
-- El sistema de reabastecimiento debe calcular cuántas cajas de 12 unidades se necesitan para empacar todo el 
-- stock actual de cada libro. No se pueden enviar cajas parciales, siempre se debe usar la caja completa 
-- siguiente si sobran unidades. Muestra el título, el stock actual y las cajas necesarias.
-- ==========================================================================================================


SELECT
	titulo,
	stock,
	CEIL(stock/12.0) AS cajas_necesarias
FROM 
	bookify.libros;


-- CASO 7
-- ==========================================================================================================
-- El área de logística quiere saber, de cada libro, cuántas docenas completas se pueden formar con el stock 
-- actual y cuántas unidades sueltas sobran. Muestra el título, las docenas completas y las unidades sueltas.
-- ==========================================================================================================


SELECT 
	titulo,
	stock,
	FLOOR(stock/ 12) AS docenas_completas,
	stock % 12 As unidades_sueltas
	FROM bookify.libros;

	
-- CASO 8
-- =======================================================================================================
-- El área de catálogo necesita un listado de todos los libros junto con el nombre de su categoría. 
-- Muestra el título del libro y el nombre de la categoría.
-- =======================================================================================================

SELECT
	libros.titulo,
	categorias.nombre
FROM 
	bookify.libros
JOIN bookify.categorias ON libros.categoria_id = categorias.id
ORDER BY
	categorias.nombre ASC;



-- CASO 9
-- =======================================================================================================
-- El equipo de logística necesita ver todos los pedidos que incluyan libros con stock menor a 10 unidades, 
-- para priorizar su surtido. Muestra número de pedido, título del libro y stock actual.
-- =======================================================================================================

SELECT 
	pedidos.numero_pedido,
	libros.titulo,
	libros.stock
FROM 
	bookify.libros 
JOIN 
	bookify.detalles_pedido ON libros.id = detalles_pedido.libro_id
JOIN 
	bookify.pedidos ON detalles_pedido.pedido_id = pedidos.id
WHERE
	libros.stock < 70;

