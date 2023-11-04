WITH selected_place AS (
SELECT osm_id
    FROM osm_seattle.place_polygon
    ORDER BY random()
    LIMIT 1
)
SELECT p.name AS place_name,
        r.osm_id, r.osm_type, r.name AS road_name,
        r.ref, r.maxspeed, r.layer, r.tunnel, r.bridge,
        r.major, r.geom
    FROM selected_place sp
    INNER JOIN osm_seattle.place_polygon p ON sp.osm_id = p.osm_id
    LEFT JOIN osm_seattle.road_line r ON p.geom && r.geom
;