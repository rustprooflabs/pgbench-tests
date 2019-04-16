
DROP TABLE IF EXISTS pgbench_reporting CASCADE;

DROP TABLE IF EXISTS pgbench_lookup1;
CREATE TABLE pgbench_lookup1 AS
SELECT generate_series::BIGINT AS id,
        REPEAT('X', (10 * (random() + 1))::INT ) AS data
    FROM generate_series(1, 10 * :scale)
;

DROP TABLE IF EXISTS pgbench_lookup2;
CREATE TABLE pgbench_lookup2 AS
SELECT generate_series::BIGINT AS id,
        REPEAT('X', (10 * (random() + 1))::INT ) AS data
    FROM generate_series(1, (SELECT COUNT(*) FROM pgbench_lookup1) * 2 )
;

DROP TABLE IF EXISTS pgbench_reporting;
CREATE TABLE pgbench_reporting AS
SELECT generate_series::BIGINT AS id,
        REPEAT('X', (25 * (random() + 1))::INT )::TEXT AS d1,
        FLOOR(random() * (SELECT MAX(id) FROM pgbench_lookup1)+ 1 )::BIGINT AS fk1,
        FLOOR(random() * (SELECT MAX(id) FROM pgbench_lookup2)+ 1 )::BIGINT AS fk2,
        (random() * 1000)::NUMERIC(8,4) AS v1,
        (random() * 10000)::INT AS v2,

        REPEAT('X', (55 * (random() + 1))::INT )::TEXT AS d2
    FROM generate_series(1, (SELECT COUNT(*) FROM pgbench_lookup1) * 10000)
;


---------------------------------------------------
---------------------------------------------------
---------------------------------------------------


ALTER TABLE pgbench_lookup1 ALTER id SET NOT NULL;
ALTER TABLE pgbench_lookup1 ALTER data SET NOT NULL;
ALTER TABLE pgbench_lookup1 
    ADD CONSTRAINT PK_pgbench_lookup1 PRIMARY KEY (id);


ALTER TABLE pgbench_lookup2 ALTER id SET NOT NULL;
ALTER TABLE pgbench_lookup2 ALTER data SET NOT NULL;
ALTER TABLE pgbench_lookup2 
    ADD CONSTRAINT PK_pgbench_lookup2 PRIMARY KEY (id);



ALTER TABLE pgbench_reporting ALTER id SET NOT NULL;
ALTER TABLE pgbench_reporting ALTER fk1 SET NOT NULL;
ALTER TABLE pgbench_reporting ALTER fk2 SET NOT NULL;
ALTER TABLE pgbench_reporting 
    ADD CONSTRAINT PK_pgbench_reporting PRIMARY KEY (id);

ALTER TABLE pgbench_reporting 
    ADD CONSTRAINT FK_pgbench_reporting_fk1
        FOREIGN KEY (fk1)
        REFERENCES pgbench_lookup1 (id)
    ;
ALTER TABLE pgbench_reporting 
    ADD CONSTRAINT FK_pgbench_reporting_fk2
        FOREIGN KEY (fk2)
        REFERENCES pgbench_lookup2 (id)
    ;

---------------------------------------------------
---------------------------------------------------
---------------------------------------------------

CREATE INDEX IX_pgbench_reporting_fk1 ON pgbench_reporting (fk1);
CREATE INDEX IX_pgbench_reporting_fk2 ON pgbench_reporting (fk2);

---------------------------------------------------
---------------------------------------------------
---------------------------------------------------

DROP VIEW IF EXISTS pgbench_view;
CREATE VIEW pgbench_view AS
SELECT r.id, r.d1, r.fk1, l1.data AS fk1data,
        r.fk2, l2.data AS fk2data,
        r.v1, r.v2, r.d2
    FROM pgbench_reporting r
    INNER JOIN pgbench_lookup1 l1 ON r.fk1 = l1.id
    INNER JOIN pgbench_lookup2 l2 ON r.fk2 = l2.id
;

VACUUM ANALYZE;

