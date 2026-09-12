-- ========================================================================

-- AUTOR:    		Sánchez Lugo Eduardo Alejandro.
-- FECHA:			12/O6/2026
-- DB: 		 		Librería.
-- MOTOR:           POSTGRESQL.
-- DESCRIPCIÓN:  	Consultas del área de almace.
-- VERSIÓN          1.0

-- ===============================================================================================
-- HISTORIAL:
-- 01/06/2026  Eduardo Sánchez  Versión inicial con Caso 1-5.


-- ===============================================================================================


-- CASO 1	
-- =======================================================================================================
-- El equipo de CRM necesita una lista de todos los clientes con su nombre completo (concatenar nombre 
-- y apellidos), su email y su ciudad. Ordenados alfabéticamente por apellido.
-- =======================================================================================================


SELECT 
	CONCAT(nombre, ' ', apellidos) AS nombre_completo, 
	email, 
	ciudad 
FROM 
	bookify.clientes
ORDER BY
	apellidos ASC;



-- CASO 2
-- =======================================================================================================
-- El área de fidelización quiere saber cuántos clientes se registraron en cada año. 
-- Extrae el año de fecha_registro
-- =======================================================================================================


SELECT  
	EXTRACT(YEAR FROM fecha_registro) AS anio, 
	COUNT(*) AS total_clientes
FROM 
	bookify.clientes
GROUP BY 
	EXTRACT(YEAR FROM fecha_registro)
ORDER BY
	anio DESC;



-- CASO 3
-- =======================================================================================================
-- El departamento de marketing quiere enviar promociones a los clientes que no tienen teléfono 
-- registrado (telefono IS NULL) pero sí tienen email. Lista sus nombres completos y emails.
-- =======================================================================================================

SELECT 
	CONCAT(nombre, ' ', apellidos) AS nombre_completo,
	email
	
FROM
	bookify.clientes
WHERE
	telefono IS NULL
AND
	email IS NOT NULL;



-- CASO 4
-- =======================================================================================================
-- El gerente de ventas necesita saber cuántos pedidos ha hecho cada cliente (cuenta de pedidos por cliente). 
-- Solo muestra a los clientes que tienen al menos 1 pedido, ordenados de mayor a menor número de pedidos.
-- =======================================================================================================


SELECT 
	cliente_id,
	COUNT(estado) AS total_pedidos
FROM
	bookify.pedidos
GROUP BY
	cliente_id
ORDER BY
	total_pedidos DESC;


-- CASO 5
-- =======================================================================================================
-- El equipo de datos quiere saber, de todos los clientes registrados, cuál es el cliente más antiguo 
-- (el de fecha_registro más temprana) y el cliente más reciente (el de fecha_registro más reciente). 
-- Muestra nombre completo y fecha de registro de ambos.
-- =======================================================================================================



SELECT * FROM bookify.clientes;

SELECT
	CONCAT(nombre, ' ', apellidos) AS nombre_completo,
	fecha_registro
FROM 
	bookify.clientes	
WHERE
	fecha_registro = (SELECT MIN(fecha_registro)FROM bookify.clientes)
	OR
	fecha_registro = (SELECT MAX(fecha_registro)FROM bookify.clientes);



