# pgbench-tests

Scripts to setup for tests in `init/`.

Scripts for tests in `tests/`

## Example Usage

Clone the repo as the `postgres` user.

```bash
sudo su - postgres
mkdir ~/git
cd ~/git
git clone https://github.com/rustprooflabs/pgbench-tests.git
cd pgbench-tests
```

Create `bench_test` database and initialize the `reporting` data.
Explore all options under `./init/`.


```bash
psql -c "CREATE DATABASE bench_test;"
psql -d bench_test -f init/reporting.sql -v scale=10
```

Run the associated tests, this example selects three tests with equal weights.

```bash
pgbench -c 10 -j 2 -T 3600 -P 60 \
    -s 10 \
    -f tests/reporting1.sql \
    -f tests/reporting2.sql@2 \
    -f tests/reporting3.sql@5 \
    bench_test
```


## PostGIS tests

Scripts under `tests/openstreetmap` require specific
OpenStreetMap (OSM) data loaded to the database.
These data are not included at this time. 

OSM files prefixed with `osm--` use the raw format loaded
by osm2pgsql.  Files prefixed with `pgosm--` use the
transformed data from the [PgOSM project](https://github.com/rustprooflabs/pgosm).

## Test results

Published pgbench results using this project. These show additional ways to use this project.

* [PostgreSQL performance on Raspberry Pi, Reporting edition](https://blog.rustprooflabs.com/2019/04/postgrseql-pgbench-raspberry-pi-pt2)
* [Large Text in PostgreSQL: Performance and Storage](https://blog.rustprooflabs.com/2020/07/postgres-storing-large-text)
* [Postgres 13 Performance with OpenStreetMap data](https://blog.rustprooflabs.com/2020/10/postgres13-openstreetmap-performance)
