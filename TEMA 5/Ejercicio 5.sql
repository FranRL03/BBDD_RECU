/* Selecciona la media, agrupada por nombre de aeropuerto de salida, del % de ocupación de los vuelos. 
PISTA: tendrás que incluir una subconsulta dentro de otra y, en la interior, usar una subconsulta 
en el select :S (o bien usar WITH) */

WITH ocupacion_por_vuelo AS (
	SELECT count(*) "num_pasajeros", id_vuelo 
	FROM reserva r 
	GROUP BY id_vuelo 
), porcentaje_ocupacion_por_vuelo AS (
	SELECT id_vuelo, desde, (num_pasajeros::NUMERIC / max_pasajeros) * 100 "porcentaje_pasajeros"
	FROM vuelo v
		JOIN ocupacion_por_vuelo USING (id_vuelo)
		JOIN avion a USING (id_avion)
)

SELECT nombre, round(avg(porcentaje_pasajeros),2) "media_pasajeros"
FROM porcentaje_ocupacion_por_vuelo
	JOIN aeropuerto a ON (desde = a.id_aeropuerto)
GROUP BY nombre;

--Selecciona el tráfico de pasajeros (es decir, personas que han llegado en un vuelo o 
--personas que han salido en un vuelo) agrupado por mes (independiente del año) y aeropuerto. 

WITH trafico_salida AS (
	SELECT a.nombre, to_char(salida, 'TMMonth') "mes", count(id_reserva) "num_pasajeros", 'salida' "tipo_trafico" 
	FROM vuelo v 
		JOIN aeropuerto a ON (a.id_aeropuerto = hasta)
		JOIN reserva r USING (id_vuelo)
	GROUP BY a.nombre, to_char(salida, 'TMMonth') 
),trafico_llegada AS (
	SELECT a.nombre, to_char(llegada, 'TMMonth') "mes", count(id_reserva) "num_pasajeros", 'llegada' "tipo_trafico" 
	FROM vuelo v 
		JOIN aeropuerto a ON (a.id_aeropuerto = desde)
		JOIN reserva r USING (id_vuelo)
	GROUP BY a.nombre, to_char(llegada, 'TMMonth') 
), trafico AS (
	SELECT *
	FROM trafico_salida
	UNION 
	SELECT *
	FROM trafico_llegada
)
SELECT nombre, mes, num_pasajeros, tipo_trafico
FROM trafico;
