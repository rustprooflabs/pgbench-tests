/*
	pgbench script to test large text operations

    Example usage:
        pgbench -c 20 -j 4 -T 60 -P 15 -n \
            -D scale=100 \
            -f tests/big_text_select_single.sql \
            bench_test

*/
\set id random(1, :scale * 10000) 

-- Calculate MD5 sum, 1 row
SELECT id, md5(val) AS val_md5
	FROM dev_text.pgbench
	WHERE id = :id
;

