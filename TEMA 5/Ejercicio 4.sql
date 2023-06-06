/* Seleccionar el vuelo más largo (con mayor duración) de cada día de la semana. 
Debe aparecer el nombre del aeropuerto de salida, el de llegada, la fecha y hora de salida 
y llegada y la duración. */

/* Seleccionar el vuelo más largo (con mayor duración) de cada día de la semana. 
Debe aparecer el nombre del aeropuerto de salida, el de llegada, la fecha y hora de salida 
y llegada y la duración. */

SELECT a2.nombre, a.nombre, salida, llegada, (llegada - salida) "duracion", to_char(salida, 'TMDay')
FROM vuelo v 
	JOIN aeropuerto a ON (a.id_aeropuerto = v.hasta)
	JOIN aeropuerto a2 ON (a2.id_aeropuerto = v.desde)
WHERE (llegada - salida) >= ALL (
					SELECT (llegada - salida)
					FROM vuelo v2 
					WHERE to_char(v.salida, 'TMDay') = to_char(v2.salida, 'TMDay')
				)
ORDER BY to_char(salida, 'TMDay')
LIMIT 1;

--Seleccionar el piso que se ha vendido más caro de cada provincia. Debe aparecer la provincia, 
--el nombre del comprador, la fecha de la operación y la cuantía.

SELECT c.nombre, fecha_operacion, precio_final, provincia
FROM inmueble i 
	JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
	JOIN operacion o USING (id_inmueble)
	JOIN comprador c USING (id_cliente)
WHERE t.nombre ILIKE 'piso'
	AND tipo_operacion ILIKE 'venta'
	AND precio_final >= ALL (
					SELECT precio_final
					FROM inmueble i2
						JOIN tipo t2 ON (t2.id_tipo = i2.tipo_inmueble)
						JOIN operacion o2 USING (id_inmueble)
					WHERE t2.nombre ILIKE 'piso'
						AND tipo_operacion ILIKE 'venta'
						AND i.provincia = i2.provincia  
							); 


/* Seleccionar los alquileres más baratos de cada provincia y mes (da igual el día y el año). 
Debe aparecer el nombre de la provincia, el nombre del mes, el resto de atributos de la tabla 
inmueble y el precio final del alquiler. */
						
SELECT TO_CHAR(o.fecha_operacion, 'TMMonth'), i.*, o.precio_final
FROM inmueble i 
	JOIN operacion o USING (id_inmueble)
WHERE tipo_operacion ILIKE 'alquiler'
	AND precio_final <= ALL (
								SELECT precio_final
								FROM inmueble i2 
									JOIN operacion o2 USING (id_inmueble)
								WHERE tipo_operacion ILIKE 'alquiler'
									AND i.provincia = i2.provincia
									AND to_char(o.fecha_operacion, 'TMMonth') 
										= to_char(o2.fecha_operacion, 'TMMonth') 
	)
ORDER BY TO_CHAR(o.fecha_operacion, 'TMMonth'),  i.provincia;


