SELECT p.name, b.osm_id, b.geom,
        COUNT(t.osm_id) AS nearby_trees
    FROM osm_wa.amenity_point b
    INNER JOIN osm_wa.place_polygon p
        ON ST_Contains(p.geom, b.geom) AND p.admin_level = '6'
    INNER JOIN osm_wa.natural_point t
        ON t.osm_type = 'tree' AND ST_DWithin(b.geom, t.geom, 10)
    WHERE b.osm_type = 'bench'
    GROUP BY p.name, b.osm_id, b.geom
    ORDER BY nearby_trees DESC
;
