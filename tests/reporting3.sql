
SELECT fk1, fk1data, fk2, fk2data,
        COUNT(*) AS cnt,
        AVG(v1) AS v1avg,
        MAX(v2) AS v2avg,
        MIN(v1 * v2) AS dumb
    FROM pgbench_view
    WHERE fk1 = 3
    GROUP BY fk1, fk1data, fk2, fk2data
    ;
