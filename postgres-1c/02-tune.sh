#!/bin/bash
set -e

# perfomance tweaks based on PgTune online
gosu postgres sed -i -e"s/^#\?max_connections =.*$/max_connections = 10/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?shared_buffers =.*$/shared_buffers = 512MB/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?effective_cache_size =.*$/effective_cache_size = 1536MB/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?work_mem =.*$/work_mem = 26214kB/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?maintenance_work_mem =.*$/maintenance_work_mem = 256MB/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?checkpoint_segments =.*$/checkpoint_segments = 128/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?checkpoint_completion_target =.*$/checkpoint_completion_target = 0.9/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?wal_buffers =.*$/wal_buffers = 16MB/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?default_statistics_target =.*$/default_statistics_target = 500/" $PGDATA/postgresql.conf

# restart pg
gosu postgres pg_ctl -D "$PGDATA" -w stop -m fast
gosu postgres pg_ctl -D "$PGDATA" -w start