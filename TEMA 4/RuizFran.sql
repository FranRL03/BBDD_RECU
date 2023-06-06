-- Ejercicio 1

SELECT DISTINCT (c.nombre)
FROM inmueble i 
	JOIN operacion o USING (id_inmueble)
	JOIN comprador c USING (id_cliente)
WHERE i.tipo_operacion  ILIKE 'alquiler'
	AND provincia IN ('Granada', 'Almería')
	AND EXTRACT (YEAR FROM fecha_operacion) = 2022;

--Ejercicio 2

SELECT round(avg(precio),2) 
FROM inmueble i 
	JOIN operacion o USING (id_inmueble)
	JOIN tipo t ON (i.id_inmueble = t.id_tipo)
WHERE provincia IN ('Málaga', 'Cádiz')
	AND to_char(fecha_operacion, 'TMMonth') = 'Agosto'
	AND tipo_operacion ILIKE 'alquiler'
	AND t.nombre ILIKE 'piso'
	AND age(fecha_alta, fecha_operacion) 
	BETWEEN '1 mon'::INTERVAL AND '3 mon'::INTERVAL;
	
--Ejercicio 3

SELECT DISTINCT(v.nombre), tipo_operacion
FROM vendedor v 
	 JOIN operacion o USING (id_vendedor)
	 LEFT JOIN inmueble i USING (id_inmueble)
	WHERE tipo_operacion ILIKE 'venta';

/* Hago un left join en inmueble para que me aparezcan todas las ventas 
 * seleccionando el nombre del vendedor con un distinct y el tipo de operacion.
 * No hay ningun vendedor que no haya hecho una venta
 */

--Ejercicio 4 

SELECT round(avg(precio - precio_final),2)  
FROM inmueble i 
	JOIN operacion o USING (id_inmueble)
	JOIN tipo t ON (i.id_inmueble = t.id_tipo)
WHERE t.nombre ILIKE 'piso'
	AND provincia IN ('Cádiz', 'Huelva')
	AND tipo_operacion ILIKE 'venta'
	AND fecha_operacion::text BETWEEN '%-03-21' AND '%-06-20';

--Ejercicio 6 

SELECT count(*)
FROM inmueble i 
	JOIN operacion o USING (id_inmueble)
WHERE tipo_operacion ILIKE 'alquiler'
	AND provincia IN ('Almería', 'Jaén');  

--Ejercicio 7

SELECT t.nombre, tipo_operacion
FROM inmueble i 
	RIGHT JOIN tipo t ON (i.id_inmueble = t.id_tipo);

	
	
