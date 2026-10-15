
from database.postgres_db import get_postgres_connection

conn = get_postgres_connection()
cur = conn.cursor()

print("\n--- COLUMN DEFAULTS AND NULL RULES ---")
cur.execute("""
    SELECT table_name, column_name, is_nullable, column_default
    FROM information_schema.columns
    WHERE table_schema = 'public'
      AND table_name IN (
          'students', 'enrollments', 'grades',
          'courses', 'instructors',
          'student_certifications', 'student_languages'
      )
    ORDER BY table_name, ordinal_position
""")
for row in cur.fetchall():
    print(row)

print("\n--- CONSTRAINTS ---")
cur.execute("""
    SELECT conrelid::regclass::text, conname, contype,
           pg_get_constraintdef(oid)
    FROM pg_constraint
    WHERE connamespace = 'public'::regnamespace
    ORDER BY conrelid::regclass::text, conname
""")
for row in cur.fetchall():
    print(row)

print("\n--- EXISTING ENROLLMENTS AND GRADES ---")
cur.execute("""
    SELECT e.student_id, e.course_id, e.semester,
           g.marks, g.grade, g.grade_point
    FROM enrollments e
    JOIN grades g ON g.enrollment_id = e.enrollment_id
    ORDER BY e.enrollment_id
    LIMIT 5
""")
for row in cur.fetchall():
    print(row)

cur.close()
conn.close()