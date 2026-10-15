#!/bin/bash
set -e

# Create the empty database before running this script.
DB_NAME="${POSTGRES_DB:-eduvault}"
DB_USER="${POSTGRES_USER:-postgres}"

psql -v ON_ERROR_STOP=1 -U "$DB_USER" -d "$DB_NAME" -f "postgresql/EduVault_backup.sql"

echo "PostgreSQL restore completed."
