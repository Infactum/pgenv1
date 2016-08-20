#!/bin/bash
set -e

# enable logging collector
gosu postgres sed -i -e"s/^#\?logging_collector =.*$/logging_collector = on/" $PGDATA/postgresql.conf

# pgbadger requirements
gosu postgres sed -i -e"s/^#\?log_min_duration_statement =.*$/log_min_duration_statement = 0/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?log_line_prefix =.*$/log_line_prefix = '%t [%p]: [%l-1] user=%u,db=%d,app=%a,client=%h '/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?log_checkpoints =.*$/log_checkpoints = on/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?log_connections =.*$/log_connections = on/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?log_disconnections =.*$/log_disconnections = on/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?log_lock_waits =.*$/log_lock_waits = on/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?log_temp_files =.*$/log_temp_files = 0/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?log_autovacuum_min_duration =.*$/log_autovacuum_min_duration = 0/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?log_error_verbosity =.*$/log_error_verbosity = default/" $PGDATA/postgresql.conf
gosu postgres sed -i -e"s/^#\?lc_messages =.*$/lc_messages = C/" $PGDATA/postgresql.conf

# restart pg
gosu postgres pg_ctl -D "$PGDATA" -w stop -m fast
gosu postgres pg_ctl -D "$PGDATA" -w start