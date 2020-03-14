# pgbench-tests

Scripts to setup for tests in `init/`.

Scripts for tests in `tests/`

## PostGIS tests

Scripts under `tests/openstreetmap` require specific
OpenStreetMap (OSM) data loaded to the database.
These data are not included at this time. 

OSM files prefixed with `osm--` use the raw format loaded
by osm2pgsql.  Files prefixed with `pgosm--` use the
transformed data from the [PgOSM project](https://github.com/rustprooflabs/pgosm).

