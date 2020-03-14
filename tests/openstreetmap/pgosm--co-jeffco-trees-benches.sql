SELECT p.osm_id, p.way, COUNT(t.osm_id) AS nearby_trees
	FROM osm.miscpoi_point p
	INNER JOIN osm.boundary_polygon b
		ON b.name = 'Jefferson County' AND ST_Contains(b.way, p.way)
	INNER JOIN osm.natural_point t
		ON t.natural = 'tree' AND ST_DWithin(p.way, t.way, 10)
	WHERE p.code = '2902'
	GROUP BY p.osm_id, p.way
	ORDER BY nearby_trees DESC, p.way
	LIMIT 10
;