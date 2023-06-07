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

/* Selecciona la media de pisos vendidos al día que se han vendido en cada provincia. Es decir, 
debes calcular primero el número de pisos que se han vendido cada día de la semana en cada provincia, 
y después, sobre eso, calcular la media por provincia. */

WITH num_pisos_vendidos AS (
	SELECT count(*) "pisos_vendidos", t.nombre, provincia, to_char(fecha_operacion, 'TMDay')
	FROM inmueble i 
		JOIN tipo t ON (i.tipo_inmueble = t.id_tipo)
		JOIN operacion o USING (id_inmueble)
	WHERE t.nombre ILIKE 'piso'
		AND tipo_operacion ILIKE 'venta'
	GROUP BY t.nombre, provincia, to_char(fecha_operacion, 'TMDay') 
)
SELECT provincia, round(avg(pisos_vendidos),2)
FROM num_pisos_vendidos
GROUP BY provincia

/* Selecciona el cliente que ha comprado más barato cada tipo de inmueble (casa, piso, local, …). 
Debe aparecer el nombre del cliente, la provincia del inmueble, la fecha de operación, el precio final 
y el nombre del tipo de inmueble. ¿Te ves capaz de modificar la consulta para que en lugar de que salga el más barato, 
salgan los 3 más baratos? */
SELECT c.nombre, t.nombre, provincia, fecha_operacion, precio_final
FROM comprador c 
	JOIN operacion o USING (id_cliente)
	JOIN inmueble i USING (id_inmueble)
	JOIN tipo t ON (i.tipo_inmueble = t.id_tipo)
WHERE tipo_operacion ILIKE 'venta'
	AND precio_final <= ALL (
							SELECT precio_final
							FROM inmueble i2 
								JOIN operacion o2 USING (id_inmueble)
								JOIN tipo t2 ON (i2.tipo_inmueble = t2.id_tipo)
							WHERE tipo_operacion ILIKE 'venta'
								AND t.id_tipo = t2.id_tipo 
							)
ORDER BY precio_final
LIMIT 3;

--De entre todos los clientes que han comprado un piso en Sevilla, 
--selecciona a los que no han realizado ninguna compra en fin de semana.

WITH compra_sevilla AS (
	SELECT *
	FROM comprador c 
		JOIN operacion o USING (id_cliente)
		JOIN inmueble i USING (id_inmueble)
		JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
	WHERE tipo_operacion ILIKE 'venta'
		AND t.nombre ILIKE 'piso'	
		AND provincia ILIKE 'sevilla'
), compra_lunes_viernes AS (
	SELECT *
	FROM compra_sevilla
	WHERE to_char(fecha_operacion, 'TMDay') BETWEEN '1' AND '5' 
), compra_finde AS (
	SELECT *
	FROM compra_sevilla
	WHERE id_cliente NOT IN (
							SELECT id_cliente 
							FROM compra_lunes_viernes
							)
)

SELECT *
FROM comprador c 
WHERE id_cliente IN (
					SELECT id_cliente 
					FROM compra_finde
					)


