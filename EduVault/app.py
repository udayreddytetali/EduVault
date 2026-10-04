import streamlit as st
import plotly.express as px

from database.postgres_db import get_postgres_connection
from database.mongo_db import get_mongo_database

from analytics.student_analysis import (
    get_student_performance,
    get_student_summary
)

from analytics.course_analysis import (
    get_course_outcomes
)

from analytics.activity_analysis import (
    get_activity_data,
    get_activity_count
)


# --------------------------------------------------
# PAGE CONFIGURATION
# --------------------------------------------------

st.set_page_config(
    page_title="EduVault",
    page_icon="🎓",
    layout="wide"
)


# --------------------------------------------------
# TITLE
# --------------------------------------------------

st.title("🎓 EduVault")
st.subheader("Academic Information & Analytics Platform")

st.write(
    "Integrated academic analytics using PostgreSQL, "
    "MongoDB, Python, Pandas and Streamlit."
)


# --------------------------------------------------
# DATABASE CONNECTION STATUS
# --------------------------------------------------

st.header("Database Status")

col1, col2 = st.columns(2)

with col1:
    try:
        conn = get_postgres_connection()
        conn.close()
        st.success("✅ PostgreSQL Connected")
    except Exception as e:
        st.error("❌ PostgreSQL Connection Failed")
        st.code(str(e))

with col2:
    try:
        mongo_db = get_mongo_database()
        mongo_db.command("ping")
        st.success("✅ MongoDB Connected")
    except Exception as e:
        st.error("❌ MongoDB Connection Failed")
        st.code(str(e))


# --------------------------------------------------
# LOAD DATA
# --------------------------------------------------

try:
    student_summary = get_student_summary()
    student_performance = get_student_performance()
    course_outcomes = get_course_outcomes()
    activity_data = get_activity_data()

except Exception as e:
    st.error("Error loading project data.")
    st.code(str(e))
    st.stop()


# --------------------------------------------------
# OVERVIEW METRICS
# --------------------------------------------------

st.header("📊 Overview")

col1, col2, col3, col4 = st.columns(4)

with col1:
    st.metric(
        "Total Students",
        student_summary["student_id"].nunique()
    )

with col2:
    st.metric(
        "Total Courses",
        course_outcomes["course_id"].nunique()
    )

with col3:
    st.metric(
        "Total Enrollments",
        student_performance.shape[0]
    )

with col4:
    st.metric(
        "Learning Activities",
        len(activity_data)
    )


# --------------------------------------------------
# STUDENT PERFORMANCE
# --------------------------------------------------

st.header("👨‍🎓 Student Performance")

st.dataframe(
    student_summary,
    use_container_width=True
)

fig_student = px.bar(
    student_summary,
    x="student_name",
    y="average_marks",
    title="Average Marks by Student",
    labels={
        "student_name": "Student",
        "average_marks": "Average Marks"
    }
)

st.plotly_chart(
    fig_student,
    use_container_width=True
)


# --------------------------------------------------
# COURSE OUTCOMES
# --------------------------------------------------

st.header("📚 Course Outcomes")

st.dataframe(
    course_outcomes,
    use_container_width=True
)

fig_course = px.bar(
    course_outcomes,
    x="course_name",
    y="average_marks",
    title="Average Marks by Course",
    labels={
        "course_name": "Course",
        "average_marks": "Average Marks"
    }
)

st.plotly_chart(
    fig_course,
    use_container_width=True
)


# --------------------------------------------------
# LEARNING ACTIVITY
# --------------------------------------------------

st.header("📖 Learning Activity")

st.metric(
    "Total Recorded Activities",
    get_activity_count()
)

if not activity_data.empty:

    st.dataframe(
        activity_data,
        use_container_width=True
    )

    # Find a suitable categorical field automatically
    possible_fields = [
        "activity_type",
        "activity",
        "type",
        "content_type"
    ]

    activity_field = None

    for field in possible_fields:
        if field in activity_data.columns:
            activity_field = field
            break

    if activity_field:

        activity_counts = (
            activity_data[activity_field]
            .value_counts()
            .reset_index()
        )

        activity_counts.columns = [
            activity_field,
            "count"
        ]

        fig_activity = px.bar(
            activity_counts,
            x=activity_field,
            y="count",
            title="Learning Activities by Type"
        )

        st.plotly_chart(
            fig_activity,
            use_container_width=True
        )

    else:
        st.info(
            "Activity records loaded successfully, "
            "but no standard activity-type field was found."
        )

else:

    st.info("No learning activity records found.")


# --------------------------------------------------
# STUDENT DETAILS
# --------------------------------------------------

st.header("🔎 Student Details")

student_names = student_summary["student_name"].tolist()

selected_student = st.selectbox(
    "Select a student",
    student_names
)

selected_data = student_performance[
    student_performance["student_name"] == selected_student
]

st.dataframe(
    selected_data,
    use_container_width=True
)