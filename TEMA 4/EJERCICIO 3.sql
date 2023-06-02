SELECT fecha_operacion, i.superficie, v.nombre 
FROM inmueble i 
	JOIN operacion o USING (id_inmueble)
	JOIN vendedor v USING (id_vendedor)
WHERE (to_char(fecha_operacion, 'TMMonth TMDay') = 'Febrero Lunes' 
	OR to_char(fecha_operacion, 'TMMonth TMDay') = 'Marzo Viernes')
AND i.superficie > 200 
AND v.nombre ILIKE '%a%';
