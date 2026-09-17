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










