/* Selecciona, agrupando por vendedor, el precio final medio de pisos y casas que se han vendido en cada provincia. 
Debe aparecer el nombre del vendedor, la provincia y el precio medio. */
						
SELECT v.nombre, provincia, avg(precio_final) 
FROM vendedor v 
	JOIN operacion o USING (id_vendedor)
	JOIN inmueble i USING (id_inmueble)
	JOIN tipo t ON (i.tipo_inmueble  = t.id_tipo)
WHERE tipo_operacion ILIKE 'venta'
	AND t.nombre IN ('Piso', 'Casa')
GROUP BY v.nombre, provincia;


/* Seleccionar la suma del precio final, agrupado por provincia, de aquellos locales donde su precio 
sea superior al producto del número de metros cuadrados de ese local por el precio medio del metro 
cuadrado de los locales de esa provincia. */

SELECT sum(precio_final) "suma_precio_final", i.provincia 
FROM inmueble i 
	JOIN operacion o USING (id_inmueble)
	JOIN tipo t ON (i.tipo_inmueble = t.id_tipo)
WHERE t.nombre ILIKE 'local'
	AND tipo_operacion ILIKE 'venta'
	AND precio_final > i.superficie * (
										SELECT avg(precio_final / superficie)
										FROM inmueble i2 
											JOIN operacion o2 USING (id_inmueble)
											JOIN tipo t2 ON (t2.id_tipo = i2.tipo_inmueble)
										WHERE t2.nombre ILIKE 'local'
											AND tipo_operacion ILIKE 'venta'
											AND i.provincia = i2.provincia
										)
GROUP BY i.provincia;

