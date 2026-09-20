#!/bin/bash
set -e

echo "Creating database 'shortlink'..."

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE shortlink;
EOSQL

echo "Database 'shortlink' created successfully."