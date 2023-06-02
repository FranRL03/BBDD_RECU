SELECT fecha_operacion, i.superficie, v.nombre 
FROM inmueble i 
	JOIN operacion o USING (id_inmueble)
	JOIN vendedor v USING (id_vendedor)
WHERE (to_char(fecha_operacion, 'TMMonth TMDay') = 'Febrero Lunes' 
	OR to_char(fecha_operacion, 'TMMonth TMDay') = 'Marzo Viernes')
AND i.superficie > 200 
AND v.nombre ILIKE '%a%';


SELECT round(avg(precio_final),2) 
FROM operacion o 
	JOIN inmueble i USING (id_inmueble)
WHERE (to_char(fecha_operacion, 'TMMonth') = 'Marzo'
	OR to_char(fecha_operacion, 'TMMonth') = 'Abril')
	AND provincia IN ('Cádiz', 'Alemería', 'Granada');
	
SELECT avg(precio - precio_final) "precio_diferencia"
FROM inmueble i 
	JOIN operacion o USING (id_inmueble)
	JOIN tipo t ON (i.tipo_inmueble = t.id_tipo)
WHERE tipo_operacion = 'Alquiler'
	AND to_char(fecha_operacion, 'TMMonth') = 'Enero'
	AND t.nombre  IN ('Oficina', 'Local', 'Suelo');

SELECT c.nombre, provincia, precio_final
FROM comprador c 
	JOIN operacion o USING (id_cliente)
	JOIN inmueble i USING (id_inmueble)
	JOIN tipo t ON (i.tipo_inmueble = t.id_tipo)
WHERE t.nombre IN ('Casa', 'Piso')
	AND (provincia ILIKE 'Jaén' 
		OR provincia ILIKE 'Córdoba')
	AND precio_final BETWEEN 150000 AND 200000;
	
SELECT *
FROM tipo;