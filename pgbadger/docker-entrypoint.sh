#!/bin/sh
set -e

PG_LOG_DIR=/var/lib/postgresql/data/pg_log 

if [ "$1" = 'nginx' ]; then
    echo "Waiting for postgre logs to appear.."
    while [ ! -f $PG_LOG_DIR/*.log ]; do
        sleep 1
    done
    pgbadger --outdir /usr/share/nginx/html --outfile index.html --format stderr $PG_LOG_DIR/*.log
fi

exec "$@"