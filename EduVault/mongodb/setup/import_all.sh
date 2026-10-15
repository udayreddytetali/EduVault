#!/bin/bash
set -e

# Run this script from the EduVault repository root.
# Requires MongoDB Database Tools (mongoimport).
# Use only on a fresh/demo database: --drop replaces each target collection.

MONGO_URI="${MONGO_URI:-mongodb://localhost:27017}"
DB_NAME="eduvault_mongo"
DATA_DIR="mongodb/data"

echo "Importing EduVault MongoDB collections..."

mongoimport --uri "$MONGO_URI" --db "$DB_NAME" --collection activity_logs --file "$DATA_DIR/activity_logs.json" --jsonArray --drop
mongoimport --uri "$MONGO_URI" --db "$DB_NAME" --collection learning_content --file "$DATA_DIR/learning_content.json" --jsonArray --drop
mongoimport --uri "$MONGO_URI" --db "$DB_NAME" --collection mongo_students --file "$DATA_DIR/mongo_students.json" --jsonArray --drop
mongoimport --uri "$MONGO_URI" --db "$DB_NAME" --collection student_activity_buckets --file "$DATA_DIR/student_activity_buckets.json" --jsonArray --drop
mongoimport --uri "$MONGO_URI" --db "$DB_NAME" --collection student_locations --file "$DATA_DIR/student_locations.json" --jsonArray --drop
mongoimport --uri "$MONGO_URI" --db "$DB_NAME" --collection validated_activity_logs --file "$DATA_DIR/validated_activity_logs.json" --jsonArray --drop

echo "MongoDB import completed."
