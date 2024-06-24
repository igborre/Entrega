-- Primera consulta al haber 500 pasadas todos terminan teniendolo, se puede ver menos personas eligiendo por ejemplo 20 dias
select p.nombre, p.apellido 
from personas p 
	join cuentas c on p.id_pers = c.id_pers_titular 
	join (select nro_cuenta
		  from pasadas 
		  where fecha_hora > now() - interval '1 month'
		  group by nro_cuenta 
		  having count(*) > 10) p2 on p2.nro_cuenta = c.nro_cuenta 
group by p.id_pers ;

-- Segunda consulta
select p.nombre, p.ruta 
from peajes p join (select p2.id_peaje
					from pasadas p2
					where fecha_hora > now() - interval '1 year'
					group by p2.id_peaje
					order by count(fecha_hora) DESC
					limit 1) as mas_pasadas on mas_pasadas.id_peaje = p.id_peaje;
					
-- Tercera consulta en esta caso no hay ninguno ya que es al azar los peajes, y al haber 16 no hay nadie que pase por el 1 10 veces 
select p.nombre, p.apellido 
from personas p 
	join cuentas c on p.id_pers = c.id_pers_titular 
	join (select nro_cuenta
		  from pasadas 
		  where fecha_hora > now() - interval '1 month' and pasadas.id_peaje = 1
		  group by nro_cuenta 
		  having count(*) > 10) p2 on p2.nro_cuenta = c.nro_cuenta 
group by p.id_pers ;

-- Cuarta consulta
SELECT p.nombre, p.telefono, COALESCE(SUM(p2.importe), 0) AS total_importe
FROM peajes p LEFT JOIN (SELECT id_peaje, SUM(importe) AS importe
    					 FROM pasadas
    					 GROUP BY id_peaje) p2 ON p.id_peaje = p2.id_peaje
GROUP BY p.id_peaje, p.nombre, p.telefono
ORDER BY COALESCE(SUM(p2.importe), 0) DESC
limit 1;

