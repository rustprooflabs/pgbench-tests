/*
	Test for the speed of queries using `FETCH FIRST N PERCENT ROWS ONLY`.

	Wrapped query from ./reporting1.sql in CTE and moved aggregation to
	outside the query.

	Example invocation:

		pgbench -c 2 -j 2 -T 600 -P 60 -s 10 \
    		--define=fetch_percent=1 \
    		-f reporting_fetch_percent.sql \
    		bench_test

*/
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
