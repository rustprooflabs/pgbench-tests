/*
	pgbench script to test large text operations

    Example usage:
        pgbench -c 20 -j 4 -T 60 -P 15 -n \
            -D scale=100 \
            -D substring_start=1 -D substring_length=100 \
            -f tests/big_text_external_select_group_substring.sql \
            bench_test

*/
\set id1 random(1, :scale * 10000) 
\set id2 random(1, :scale * 10000) 
\set id3 random(1, :scale * 10000) 
\set id4 random(1, :scale * 10000) 
\set id5 random(1, :scale * 10000) 


SELECT id, SUBSTRING(val, :substring_start, :substring_length)
	FROM dev_text.pgbench_ext
	WHERE id IN (:id1, :id2, :id3, :id4, :id5)
;