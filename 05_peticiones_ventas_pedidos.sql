-- ========================================================================

-- AUTOR:    		Sánchez Lugo Eduardo Alejandro.
-- FECHA:			01/O6/2026
-- DB: 		 		Librería.
-- MOTOR:           POSTGRESQL.
-- DESCRIPCIÓN:  	Consultas del área de almace.
-- VERSIÓN          1.0

-- ===============================================================================================
-- HISTORIAL:
-- 01/06/2026  Eduardo Sánchez  Versión inicial con Caso 1.


-- ===============================================================================================


-- CASO 1	
-- =======================================================================================================
-- El gerente de ventas quiere un reporte que muestre cuántos pedidos se han realizado en total 
-- y cuál es el monto total acumulado (suma de la columna total de la tabla pedidos).
-- =======================================================================================================

SELECT 
	COUNT(*) AS total_pedidos,
	SUM(total) AS total_monto
FROM bookify.pedidos;

-- CASO 2	
-- =======================================================================================================
-- El departamento de marketing necesita identificar los 3 pedidos con el monto total más alto 
-- (top 3 por total), para estudiar patrones de compra de clientes de alto valor.
-- =======================================================================================================

SELECT
	id,
	cliente_id,
	total
FROM bookify.pedidos
ORDER BY total DESC
LIMIT 3;


-- CASO 3	
-- =======================================================================================================
-- El área de logística pregunta: ¿cuál es el promedio de gastos de envío (gastos_envio) por pedido? Y también,
-- ¿cuál es el gasto de envío más caro y el más barato registrado hasta ahora?
-- =======================================================================================================

SELECT 
	ROUND(AVG(gastos_envio),2) AS promedio_gastos_envio,
	MAX(gastos_envio) AS envio_mas_caro,
	MIN(gastos_envio) As envio_mas_barato
FROM bookify.pedidos;
