-- ========================================================================

-- AUTOR:    		Sánchez Lugo Eduardo Alejandro.
-- FECHA:			12/O6/2026
-- DB: 		 		Librería.
-- MOTOR:           POSTGRESQL.
-- DESCRIPCIÓN:  	Consultas del área de auditoria y calidad.
-- VERSIÓN          1.0

-- ===============================================================================================
-- HISTORIAL:
-- 12/06/2026  Eduardo Sánchez  Versión inicial con Caso 1 y 2.

-- ===============================================================================================


-- CASO 1
-- =======================================================================================================
-- El área de auditoría interna necesita verificar que los emails de los clientes cumplan con el formato 
-- estándar (usuario@dominio.extension). Muestra el email y una columna que indique si cumple o no.
-- ======================================================================================================

SELECT * FROM bookify.clientes;


SELECT
	email,
	CASE
		WHEN email ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN 'Cumple'
		ELSE 'No cumple'
	END AS validacion_email
FROM 
	bookify.clientes;


-- CASO 2
-- =======================================================================================================
-- El área de auditoría quiere verificar qué autores tienen libros publicados en más de una 
-- categoría diferente. Muestra el nombre completo del autor y la cantidad de categorías distintas
-- en las que tiene libros.
-- ======================================================================================================


SELECT 
	CONCAT(autores.nombre, ' ',autores.apellidos) AS nombre_completo,
	COUNT(DISTINCT categorias.id) AS cantidad_categorias
	
FROM 
	bookify.libros
JOIN 
	bookify.categorias ON libros.categoria_id = categorias.id
JOIN 
	bookify.libros_autores ON libros.id = libros_autores.libro_id
JOIN
	bookify.autores ON libros_autores.autor_id = autores.id
GROUP BY 
	autores.id, autores.nombre, autores.apellidos
HAVING
	COUNT(DISTINCT categorias.id) > 1
ORDER BY 
	nombre_completo ASC;


	