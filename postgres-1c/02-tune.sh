#!/bin/bash
set -e

cp /usr/local/src/postgresql.conf $PGDATA/postgresql.conf
chown postgres $PGDATA/postgresql.conf

# restart pg
gosu postgres pg_ctl -D "$PGDATA" -w stop -m fast
gosu postgres pg_ctl -D "$PGDATA" -w start