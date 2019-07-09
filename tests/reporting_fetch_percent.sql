WITH t AS (
 SELECT fk1, fk1data, v1, v2
    FROM pgbench_view
    FETCH FIRST :fetch_percent PERCENT ROWS ONLY
)
SELECT fk1, fk1data, COUNT(*) AS cnt,
        AVG(v1) AS v1avg,
        MAX(v2) AS v2avg
    FROM t
    GROUP BY fk1, fk1data
;
