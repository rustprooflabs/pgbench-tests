/* 
    pgbench script to test insert speed, single row


    Example usage:
        pgbench -c 20 -j 4 -T 3600 -P 30 -n \
            -D base_length=55 \
            -f tests/big_text_insert.sql \
            bench_test

*/
INSERT INTO dev_text.pgbench (val)
SELECT repeat(md5(random()::TEXT),
            :base_length + ceil(random() * 25)::INT)
;