import pandas as pd
from database.postgres_db import fetch_dataframe


def get_student_performance():
    query = """
    SELECT
        s.student_id,
        s.roll_number,
        s.student_name,
        d.department_name,
        c.course_code,
        c.course_name,
        e.semester,
        g.marks,
        g.grade,
        g.grade_point
    FROM students s
    JOIN departments d
        ON s.department_id = d.department_id
    JOIN enrollments e
        ON s.student_id = e.student_id
    JOIN courses c
        ON e.course_id = c.course_id
    JOIN grades g
        ON e.enrollment_id = g.enrollment_id
    ORDER BY s.student_id, c.course_id;
    """

    return fetch_dataframe(query)


def get_student_summary():
    query = """
    SELECT
        s.student_id,
        s.roll_number,
        s.student_name,
        d.department_name,
        COUNT(e.enrollment_id) AS courses_taken,
        ROUND(AVG(g.marks), 2) AS average_marks
    FROM students s
    JOIN departments d
        ON s.department_id = d.department_id
    LEFT JOIN enrollments e
        ON s.student_id = e.student_id
    LEFT JOIN grades g
        ON e.enrollment_id = g.enrollment_id
    GROUP BY
        s.student_id,
        s.roll_number,
        s.student_name,
        d.department_name
    ORDER BY s.student_id;
    """

    return fetch_dataframe(query)