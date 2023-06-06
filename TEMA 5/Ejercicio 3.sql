--Selecciona los clientes que han comprado casas en Almería, siendo el precio final mayor 
--que el precio medio de las casas vendidas en Almería.

SELECT c.nombre
FROM comprador c 
	JOIN operacion o USING (id_cliente)
	JOIN inmueble i USING (id_inmueble)
	JOIN tipo t ON (i.id_inmueble = t.id_tipo)
WHERE tipo_operacion ILIKE 'venta'
	AND provincia ILIKE 'almería'
	AND t.nombre ILIKE 'casa'
	AND precio_final >= ALL (
							SELECT avg(precio_final)
							FROM inmueble i2 
								JOIN operacion o2 USING (id_inmueble)
								JOIN tipo t2 ON (i2.id_inmueble = t2.id_tipo)
							WHERE tipo_operacion ILIKE 'venta'
								AND provincia ILIKE 'almería'
								AND t2.nombre ILIKE 'casa'
							);
											
--Selecciona de todos los vendedores a aquellos que solo vendieron inmuebles de tipo Parking

SELECT v.nombre
FROM vendedor v 
	JOIN operacion o USING (id_vendedor)
	JOIN inmueble i USING (id_inmueble)
	JOIN tipo t ON (t.id_tipo = i.id_inmueble)
WHERE tipo_operacion ILIKE 'venta'
	AND t.nombre ILIKE 'parking'
	AND v.nombre NOT IN (
						SELECT v2.nombre
						FROM vendedor v2 
							JOIN operacion o2 USING (id_vendedor)
							JOIN inmueble i2 USING (id_inmueble)
							JOIN tipo t2 ON (t2.id_tipo = i2.id_inmueble)
						WHERE t2.nombre NOT ILIKE 'parking'
							AND tipo_operacion ILIKE 'venta'
						);

--Seleccionar los 3 aeropuertos que menos tráfico de llegada (menos personas llegando 
--a ellos en un vuelo) han registrado en un mes de Enero, Febrero o Marzo

SELECT a.nombre,max_pasajeros, llegada
FROM vuelo v 
	JOIN aeropuerto a ON (v.hasta  = a.id_aeropuerto)
	JOIN avion a2 USING (id_avion)
WHERE EXTRACT (MONTH FROM v.llegada) IN (1,2,3)
ORDER BY max_pasajeros
LIMIT 3;

--Selecciona el origen y el destino de los 10 vuelos con una duración menor. 
--Debes realizarlo usando subconsultas.

SELECT a.nombre "desde", a2.nombre "hasta", (llegada - salida) "duracion"
FROM vuelo v 
	JOIN aeropuerto a ON (desde = a.id_aeropuerto)
	JOIN aeropuerto a2 ON (hasta = a2.id_aeropuerto)
WHERE llegada - salida IN (
							SELECT llegada - salida 
							FROM vuelo v2
							ORDER BY (v2.llegada - v2.salida)
							)
ORDER BY duracion
LIMIT 10;



/* Selecciona el importe que la aerolínea de la base de datos de vuelos ha
ingresado por cada uno de los vuelos que se han realizado en fin de semana
(es decir, que han salido entre viernes y domingo) en los meses de Julio y
Agosto (da igual el año). */
SELECT SUM (precio)
FROM vuelo v
WHERE salida IN (
				SELECT salida
				FROM vuelo
				WHERE TO_CHAR (salida, 'TMMonth') IN ('Julio', 'Agosto')
					AND TO_CHAR (salida, 'id') IN ('5','6','7')
);


	

