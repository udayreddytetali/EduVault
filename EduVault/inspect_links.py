
from database.postgres_db import fetch_dataframe
from database.mongo_db import get_mongo_database

print("\n--- DEPARTMENTS ---")
print(fetch_dataframe(
    "SELECT department_id, department_name FROM departments"
).to_string(index=False))

print("\n--- STUDENTS ---")
print(fetch_dataframe(
    "SELECT student_id, roll_number, student_name, department_id "
    "FROM students ORDER BY student_id"
).to_string(index=False))

print("\n--- COURSES ---")
print(fetch_dataframe(
    "SELECT course_id, course_code, course_name, department_id "
    "FROM courses ORDER BY course_id"
).to_string(index=False))

db = get_mongo_database()

print("\n--- MONGODB COURSE CODES ---")
print("Learning content:", db["learning_content"].distinct("course_code"))
print("Activity logs:", db["activity_logs"].distinct("course_code"))

print("\n--- MONGODB STUDENT IDS ---")
print(db["activity_logs"].distinct("student_id"))