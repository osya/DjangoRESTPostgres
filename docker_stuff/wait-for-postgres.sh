#!/bin/bash
# wait-for-postgres.sh

set -e

host="$1"
port="$2"
db="$3"
shift 3
cmd="$@"

until psql -h "$host" -p "$port" -d "$db" -w -c '\l'; do
  >&2 echo "Postgres is unavailable - sleeping"
  sleep 1
done

>&2 echo "Postgres is up - executing command"
exec ${cmd}
