-- ========================================================================

-- AUTOR:    		Sánchez Lugo Eduardo Alejandro.
-- FECHA:			28/O5/2026
-- DB: 		 		Librería.
-- MOTOR:           POSTGRESQL.
-- DESCRIPCIÓN:  	Consultas del área de almace.
-- VERSIÓN          1.0

-- ===============================================================================================
-- HISTORIAL:
-- 28/05/2026  Eduardo Sánchez  Versión inicial con Caso 1.
-- 29/05/2026  Roxana Sosa 		Se agregó caso 2, 3, 4 y 5.
-- 02/06/2026  Roxana Sosa 		Se agregó caso 6,7 y 8.

-- ===============================================================================================


-- CASO 1	
-- =======================================================================================================
-- El gerente de ventas quiere un reporte que muestre cuántos pedidos se han realizado en total 
-- y cuál es el monto total acumulado 
-- =======================================================================================================

SELECT 
	COUNT(fecha_pedi) AS total_pedidos,
	SUM(total) AS monto_total_pedidos
FROM bookify.pedidos;


-- CASO 2	
-- ================================================================================================================
-- El departamento de marketing necesita identificar los 3 pedidos con el monto total más alto (top 3 por total), 
-- para estudiar patrones de compra de clientes de alto valor. 
-- ================================================================================================================

SELECT 
	numero_pedido,
	total
FROM bookify.pedidos
ORDER BY total DESC
FETCH FIRST 3 ROWS WITH TIES;

-- CASO 3	
-- ================================================================================================================
-- El área de logística pregunta: ¿cuál es el promedio de gastos de envío (gastos_envio) por pedido? Y también, 
-- ¿cuál es el gasto de envío más caro y el más barato registrado hasta ahora? 
-- ================================================================================================================

SELECT
	ROUND(AVG(gastos_envio),2) AS promedio_gatos_envio,
	MAX(gastos_envio) AS  gasto_envio_caro,
	MIN(gastos_envio) AS gasto_envio_barato
FROM  bookify.pedidos;

-- CASO 4	
-- ==================================================================================================================
-- El equipo de operaciones quiere saber cuántos pedidos hay agrupados por estado (pendiente, confirmado, procesando, 
-- enviado, entregado, cancelado), para visualizar el embudo de cumplimiento. 
-- ==================================================================================================================

SELECT
	estado,
 	COUNT(*) AS total_pedidos
FROM bookify.pedidos
GROUP BY estado
ORDER BY total_pedidos DESC;

-- CASO 5	
-- ==================================================================================================================
-- El director financiero pide un análisis: de todos los pedidos entregados, ¿cuál es el subtotal promedio, 
-- el impuesto promedio y el total promedio? (Solo de entregados). 
-- ==================================================================================================================

SELECT
	ROUND(AVG(subtotal),2) AS subtotal_promedio,
	ROUND(AVG(impuestos),2) AS impuesto_promedio,
	ROUND(AVG(total),2) AS total_promedio
FROM bookify.pedidos
WHERE estado = 'entregado';


-- CASO 6	
-- ==================================================================================================================
-- El equipo de marketing quiere identificar a los clientes que han gastado más de $ 50 en total 
-- (suma de todos sus pedidos). Muestra el ID del cliente y el total gastado, sin decimales. Ordena de mayor 
-- a menor gasto.
-- ==================================================================================================================


SELECT
	cliente_id,
	ROUND(SUM(total), 0) AS total_gastado
FROM 
	bookify.pedidos
GROUP BY
	cliente_id
HAVING
	SUM(total) > 50
ORDER BY 
	total_gastado DESC;
	

-- CASO 7	
-- ==================================================================================================================
-- El departamento de logística necesita saber, para cada estado de pedido, el promedio de gastos de envío. 
-- La empresa presupuesta de manera conservadora, por lo que cualquier cálculo de costos debe ajustarse al siguiente
-- número entero hacia arriba. Muestra el estado del pedido y el gasto de envío promedio ajustado.
-- ==================================================================================================================


SELECT
	estado,
	CEIL(AVG(gastos_envio)) AS envio_promedio_ajustado
FROM 
	bookify.pedidos
GROUP BY
	estado;


-- CASO 8	
-- ==================================================================================================================
-- El director financiero quiere un reporte de totales de pedidos por cliente, pero solo de aquellos clientes 
-- cuyo total promedio por pedido esté entre $30 y $200 (inclusive). Muestra el ID del cliente y el promedio
-- por pedido, con un decimal. Adicionalmente, por razones de auditoría, incluye una versión del mismo promedio 
-- recortando los decimales sin redondear, para comparar ambos cálculos.
-- ==================================================================================================================


SELECT
	cliente_id,
	ROUND(AVG(total),1) AS promedio_decimal,
	TRUNC(AVG(TOTAL), 0) AS promedio_recortado
FROM 
	bookify.pedidos
GROUP BY 
	cliente_id
HAVING
	AVG(total) BETWEEN 30 AND 200;

