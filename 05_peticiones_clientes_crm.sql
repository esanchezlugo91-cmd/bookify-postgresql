-- ========================================================================

-- AUTOR:    		Sánchez Lugo Eduardo Alejandro.
-- FECHA:			01/O6/2026
-- DB: 		 		Librería.
-- MOTOR:           POSTGRESQL.
-- DESCRIPCIÓN:  	Consultas del área de almace.
-- VERSIÓN          1.0

-- ===============================================================================================
-- HISTORIAL:
-- 01/06/2026  Eduardo Sánchez  Versión inicial con Caso 1-3.
-- 02/06/2026  Rogelio Hernandez  Versión inicial con Caso 4 y 5.

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
	telefono IS NULL,
	email IS 	
FROM
	bookify.clientes;


-- CASO 4
-- =======================================================================================================
-- El equipo de CRM quiere saber, por cada año de registro de clientes, cuántos clientes se registraron. 
-- Muestra solo los años que tengan más de 5 clientes registrados. El año debe mostrarse como número entero. 
-- Ordena del año más reciente al más antiguo.
-- =======================================================================================================


SELECT
	EXTRACT(YEAR FROM fecha_registro)::int AS anio,
	COUNT(id) AS total_clientes
FROM 
	bookify.clientes
GROUP BY
	EXTRACT(YEAR FROM fecha_registro)
HAVING 
	COUNT(id) > 5
ORDER BY 
	anio DESC;


-- CASO 5
-- =======================================================================================================
-- El área de fidelización quiere clasificar a los clientes por antigüedad en años completos 
-- (solo cuentan años enteros cumplidos). Muestra el nombre completo del cliente, su fecha de registro 
-- y los años completos desde que se registró hasta hoy. Ordena del cliente más antiguo al más reciente.
-- =======================================================================================================


SELECT
	CONCAT(nombre, ' ', apellidos) AS nombre_completo, 
	fecha_registro,
	EXTRACT(YEAR FROM AGE(CURRENT_DATE, fecha_registro))::int AS anis_completos
FROM bookify.clientes
ORDER BY
	fecha_registro ASC;



