from database.postgres_db import get_postgres_connection

conn = get_postgres_connection()
cur = conn.cursor()

cur.execute("""
    SELECT table_name, column_name, data_type
    FROM information_schema.columns
    WHERE table_schema = 'public'
    ORDER BY table_name, ordinal_position
""")

for row in cur.fetchall():
    print(row)

cur.close()
conn.close()