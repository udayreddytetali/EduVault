import random
from datetime import datetime, timedelta

from database.postgres_db import get_postgres_connection
from database.mongo_db import get_mongo_database

# Repeatable demo data. Existing records are preserved.
rng = random.Random(20261012)
MARKER = "eduvault_bulk_v1"

FIRST_NAMES = [
    "Aarav", "Ananya", "Arjun", "Diya", "Ishaan", "Kavya", "Rahul",
    "Priya", "Sneha", "Vikram", "Aditya", "Meera", "Rohan", "Saanvi",
    "Varun", "Nisha", "Kiran", "Pooja", "Sai", "Keerthi"
]
LAST_NAMES = [
    "Sharma", "Reddy", "Kumar", "Patel", "Verma",
    "Rao", "Singh", "Gupta", "Naidu", "Das"
]
CERTIFICATIONS = [
    "Python Programming", "SQL Fundamentals", "Data Analytics",
    "Web Development", "Cloud Fundamentals", "Machine Learning Basics"
]
LANGUAGES = ["Python", "SQL", "Java", "JavaScript", "C++"]

def grade_for(marks):
    if marks >= 90:
        return "A+", 10.0
    if marks >= 80:
        return "A", 9.0
    if marks >= 70:
        return "B+", 8.0
    if marks >= 60:
        return "B", 7.0
    if marks >= 50:
        return "C", 6.0
    return "D", 5.0

# ---------- PostgreSQL ----------
conn = get_postgres_connection()
cur = conn.cursor()
generated_students = []
course_info = []

try:
    cur.execute("SELECT department_id FROM departments ORDER BY department_id")
    department_ids = [row[0] for row in cur.fetchall()]
    if not department_ids:
        raise RuntimeError("No departments exist. Add departments before loading data.")

    cur.execute("""
        SELECT course_id, course_code, course_name
        FROM courses
        ORDER BY course_code
    """)
    course_info = cur.fetchall()
    if not course_info:
        raise RuntimeError("No courses exist. Add courses before loading data.")

    # 100 synthetic students. Unique roll numbers make reruns safe.
    for i in range(1, 101):
        roll = f"EV26{i:04d}"
        first = FIRST_NAMES[(i - 1) % len(FIRST_NAMES)]
        last = LAST_NAMES[((i - 1) // len(FIRST_NAMES) + i) % len(LAST_NAMES)]
        name = f"{first} {last} {i:03d}"
        email = f"{roll.lower()}@eduvault.demo"

        cur.execute("""
            INSERT INTO students
                (roll_number, student_name, email, gender, date_of_birth,
                 department_id, admission_year)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            ON CONFLICT (roll_number) DO NOTHING
        """, (
            roll, name, email,
            "Female" if i % 2 == 0 else "Male",
            datetime(2002 + i % 5, 1 + i % 12, 1 + i % 27).date(),
            department_ids[(i - 1) % len(department_ids)],
            2025
        ))

    cur.execute("""
        SELECT student_id, roll_number
        FROM students
        WHERE roll_number LIKE 'EV26%'
        ORDER BY roll_number
    """)
    generated_students = cur.fetchall()

    # Each student takes every available course, across two semesters.
    split_at = max(1, (len(course_info) + 1) // 2)
    for student_id, roll in generated_students:
        for index, (course_id, course_code, course_name) in enumerate(course_info):
            semester = "Semester 1" if index < split_at else "Semester 2"

            cur.execute("""
                INSERT INTO enrollments
                    (student_id, course_id, semester, enrollment_date)
                VALUES (%s, %s, %s, %s)
                ON CONFLICT (student_id, course_id, semester) DO NOTHING
                RETURNING enrollment_id
            """, (student_id, course_id, semester, datetime(2025, 8, 1).date()))
            inserted = cur.fetchone()

            if inserted:
                enrollment_id = inserted[0]
                marks = rng.randint(45, 99)
                grade, point = grade_for(marks)
                cur.execute("""
                    INSERT INTO grades (enrollment_id, marks, grade, grade_point)
                    VALUES (%s, %s, %s, %s)
                    ON CONFLICT (enrollment_id) DO NOTHING
                """, (enrollment_id, marks, grade, point))

        suffix = int(roll[-4:])
        cur.execute("""
            INSERT INTO student_certifications (student_id, certification)
            VALUES (%s, %s) ON CONFLICT DO NOTHING
        """, (student_id, CERTIFICATIONS[suffix % len(CERTIFICATIONS)]))
        cur.execute("""
            INSERT INTO student_languages (student_id, language)
            VALUES (%s, %s) ON CONFLICT DO NOTHING
        """, (student_id, LANGUAGES[suffix % len(LANGUAGES)]))

    conn.commit()
    print(f"PostgreSQL: {len(generated_students)} generated students are available.")
    print(f"PostgreSQL: {len(generated_students) * len(course_info)} expected generated enrollments.")
except Exception:
    conn.rollback()
    raise
finally:
    cur.close()
    conn.close()

# ---------- MongoDB ----------
# Only this script's own generated documents are replaced on rerun.
db = get_mongo_database()
content_col = db["learning_content"]
activity_col = db["activity_logs"]
content_col.delete_many({"generated_by": MARKER})
activity_col.delete_many({"generated_by": MARKER})

materials = []
for course_id, code, course_name in course_info:
    materials.append({
        "content_id": f"EV-LC-{code}",
        "course_code": code,
        "title": f"{course_name}: Learning Guide",
        "content_type": "Video",
        "topic": f"{course_name} Fundamentals",
        "instructor": "EduVault Academic Team",
        "duration_minutes": 10 + (course_id % 31),
        "tags": [code, course_name.lower(), "learning", "demo"],
        "uploaded_date": datetime(2026, 9, 1),
        "generated_by": MARKER
    })

if materials:
    content_col.insert_many(materials)

# Each generated student gets 10 realistic, course-linked activity events.
activity_docs = []
base_date = datetime(2026, 9, 1)
activity_types = [
    "Video Watched", "Quiz Attempted",
    "Notes Read", "Assignment Completed"
]
course_codes = [row[1] for row in course_info]

for student_id, roll in generated_students:
    for j in range(10):
        code = course_codes[(int(roll[-4:]) + j) % len(course_codes)]
        duration = rng.randint(5, 40)
        activity_docs.append({
            "student_id": student_id,
            "course_code": code,
            "activity_type": activity_types[j % len(activity_types)],
            "content_id": f"EV-LC-{code}",
            "duration_minutes": duration,
            "completion_percentage": rng.choice([25, 40, 50, 60, 75, 80, 90, 100]),
            "timestamp": base_date + timedelta(
                days=(int(roll[-4:]) + j) % 40,
                minutes=j * 15
            ),
            "generated_by": MARKER
        })

for start in range(0, len(activity_docs), 500):
    activity_col.insert_many(activity_docs[start:start + 500])

print(f"MongoDB: {len(materials)} learning materials added.")
print(f"MongoDB: {len(activity_docs)} linked activity logs added.")
print("DONE. Existing non-generated data was preserved.")
