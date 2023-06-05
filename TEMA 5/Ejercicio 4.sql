/* Seleccionar el vuelo más largo (con mayor duración) de cada día de la semana. 
Debe aparecer el nombre del aeropuerto de salida, el de llegada, la fecha y hora de salida 
y llegada y la duración. */

SELECT a2.nombre, a.nombre, salida, llegada, (salida - llegada) "duracion", to_char(salida, 'TMDay')
FROM vuelo v 
	JOIN aeropuerto a ON (a.id_aeropuerto = v.hasta)
	JOIN aeropuerto a2 ON (a2.id_aeropuerto = v.desde)
WHERE (salida - llegada) <= ALL (
					SELECT (salida - llegada)
					FROM vuelo v2 
					WHERE to_char(v.salida, 'TMDay') = to_char(v2.salida, 'TMDay')
				)
ORDER BY to_char(salida, 'TMDay'); 


