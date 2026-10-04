from database.postgres_db import fetch_dataframe


def get_course_outcomes():
    query = """
    SELECT
        c.course_id,
        c.course_code,
        c.course_name,
        COUNT(e.enrollment_id) AS students_enrolled,
        ROUND(AVG(g.marks), 2) AS average_marks,
        MAX(g.marks) AS highest_marks,
        MIN(g.marks) AS lowest_marks
    FROM courses c
    LEFT JOIN enrollments e
        ON c.course_id = e.course_id
    LEFT JOIN grades g
        ON e.enrollment_id = g.enrollment_id
    GROUP BY
        c.course_id,
        c.course_code,
        c.course_name
    ORDER BY c.course_id;
    """

    return fetch_dataframe(query)