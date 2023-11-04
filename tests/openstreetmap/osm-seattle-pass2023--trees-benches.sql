WITH selected_place AS (
SELECT osm_id
    FROM osm_seattle.place_polygon
    ORDER BY random()
    LIMIT 1
)
SELECT p.osm_id, COUNT(DISTINCT a.osm_id) AS bench_count,
        COUNT(n.osm_id )AS trees_near_bench_count
    FROM selected_place sp
    INNER JOIN osm_seattle.place_polygon p ON sp.osm_id = p.osm_id
    LEFT JOIN osm_seattle.amenity_point a
        ON ST_Contains(p.geom, a.geom)
            AND a.osm_type = 'bench'
    LEFT JOIN osm_seattle.natural_point n
        ON ST_DWithin(a.geom, n.geom, 50)
            AND n.osm_type = 'tree'
    GROUP BY p.osm_id
;