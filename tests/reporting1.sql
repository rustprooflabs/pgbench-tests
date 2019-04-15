 SELECT fk1, fk1data, COUNT(*) AS cnt,
        AVG(v1) AS v1avg,
        MAX(v2) AS v2avg
    FROM pgbench_view
    GROUP BY fk1, fk1data
    ;
