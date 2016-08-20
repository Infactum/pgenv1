#!/bin/bash
set -e

# Configure shared_preload_libraries
gosu postgres sed -i -e"s/^shared_preload_libraries = '\(.*\)'.*$/shared_preload_libraries = '\1, pg_stat_statements, powa,pg_qualstats, pg_stat_kcache'/" $PGDATA/postgresql.conf

# restart pg
gosu postgres pg_ctl -D "$PGDATA" -w stop -m fast
gosu postgres pg_ctl -D "$PGDATA" -w start

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<EOSQL
    CREATE EXTENSION hypopg;
    CREATE database powa;
    \c powa
    CREATE EXTENSION pg_stat_statements;
    CREATE EXTENSION btree_gist;
    CREATE EXTENSION pg_qualstats;
    CREATE EXTENSION pg_stat_kcache;
    CREATE EXTENSION pg_track_settings;
    CREATE EXTENSION powa;
    \c template1
    CREATE EXTENSION hypopg;
EOSQL
