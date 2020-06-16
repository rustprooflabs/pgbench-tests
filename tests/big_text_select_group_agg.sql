/*
	pgbench script to test large text operations

    Example usage:
        pgbench -c 20 -j 4 -T 60 -P 15 -n \
            -D scale=100 \
            -f tests/big_text_select_group_agg.sql \
            bench_test

*/
\set id1 random(1, :scale * 10000) 
\set id2 random(1, :scale * 10000) 
\set id3 random(1, :scale * 10000) 
\set id4 random(1, :scale * 10000) 
\set id5 random(1, :scale * 10000) 


-- Average length for subset of table
SELECT COUNT(id),
		AVG(LENGTH(val)) AS len_avg
	FROM dev_text.pgbench
	WHERE id IN (:id1, :id2, :id3, :id4, :id5)
;