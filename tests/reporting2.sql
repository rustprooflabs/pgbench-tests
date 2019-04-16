 \set sel_fk1 random(1, :scale * 10) 

 SELECT fk1, fk1data, COUNT(*) AS cnt,
        AVG(v1) AS v1avg,
        MAX(v2) AS v2avg,
        MIN(v1 * v2) AS dumb
    FROM pgbench_view
    WHERE fk1 = :sel_fk1
    GROUP BY fk1, fk1data
    ;

