import streamlit as st
import pandas as pd
import plotly.express as px
from database.postgres_db import get_postgres_connection
from database.mongo_db import get_mongo_database
from analytics.student_analysis import get_student_performance, get_student_summary
from analytics.course_analysis import get_course_outcomes
from analytics.activity_analysis import get_activity_data

st.set_page_config(
    page_title="EduVault | Academic Intelligence",
    page_icon="🎓",
    layout="wide",
    initial_sidebar_state="expanded"
)

# ---------- THEME ----------
st.markdown("""
<style>
:root { color-scheme: dark; }
.stApp {
  background: radial-gradient(ellipse at 5% 0%, #182345 0%, #0b1020 42%, #090d18 100%);
  color: #e8edf7;
}
.block-container { max-width: 1500px; padding-top: 1.5rem; padding-bottom: 3rem; }
header[data-testid="stHeader"] { background: rgba(9,13,24,.8); }
section[data-testid="stSidebar"] {
  background: linear-gradient(180deg, #101a30 0%, #0b1120 100%);
  border-right: 1px solid #26334b;
}
section[data-testid="stSidebar"] * { color: #dbe5f5; }
[data-testid="stMetric"] {
  background: linear-gradient(145deg, rgba(27,39,65,.95), rgba(17,26,45,.95));
  border: 1px solid #2b3a57; border-radius: 16px; padding: 17px 18px;
}
[data-testid="stMetricLabel"] { color: #9eafc9 !important; }
[data-testid="stMetricValue"] { color: #f4f7ff !important; font-weight: 750; }
.hero {
  background: linear-gradient(120deg, #172746 0%, #202d52 50%, #31265f 100%);
  border: 1px solid #3a4770; border-radius: 22px; padding: 26px 30px;
  margin: 0 0 20px 0; box-shadow: 0 18px 50px rgba(0,0,0,.22);
}
.hero h1 { margin: 0; color: #fff; font-size: 2.35rem; letter-spacing: -.7px; }
.hero p { color: #bdc9e0; margin: 7px 0 0 0; font-size: 1rem; }
.eyebrow { color: #a5b4fc; font-size: .75rem; font-weight: 800; letter-spacing: 2px; text-transform: uppercase; }
.section-title { color: #f2f6ff; font-size: 1.45rem; font-weight: 750; margin: 18px 0 3px 0; }
.section-note { color: #94a6c2; margin-bottom: 14px; font-size: .9rem; }
.panel {
  background: rgba(18,27,46,.86); border: 1px solid #273650;
  border-radius: 17px; padding: 17px 19px; margin-bottom: 14px;
}
.panel h3 { color: #eef3ff; margin-top: 0; }
.small-muted { color: #96a8c4; font-size: .86rem; }
div[data-testid="stDataFrame"] { border: 1px solid #293954; border-radius: 12px; overflow: hidden; }
.stButton > button { border-radius: 10px; border: 1px solid #40547a; }
div[data-baseweb="select"] > div { background: #141e33; border-color: #354765; }
hr { border-color: #293650; }
.footer { color: #7f91ad; text-align: center; padding: 28px 0 5px 0; font-size: .8rem; }
</style>
""", unsafe_allow_html=True)

# ---------- TOP NAVIGATION ----------
pages = [
    "Overview", "Student Performance", "Course Outcomes",
    "Learning Activity", "Student Explorer"
]
if "eduvault_page" not in st.session_state:
    st.session_state.eduvault_page = "Overview"

# Keep the sidebar out of the way: navigation is in the main top bar.
st.markdown("""
<style>
[data-testid="stSidebar"] {display: none;}
.topnav-wrap {
  position: sticky; top: 0; z-index: 999;
  background: rgba(9, 13, 24, .96);
  border: 1px solid #293954; border-radius: 16px;
  padding: 10px 12px; margin: 0 0 18px 0;
  backdrop-filter: blur(16px);
}
.topnav-label {color:#94a6c2;font-size:.72rem;font-weight:800;letter-spacing:1.7px;text-transform:uppercase;margin:0 0 8px 4px;}
div.stButton > button {min-height:44px; font-weight:650; white-space:normal;}
</style>
""", unsafe_allow_html=True)

# Brand header
brand_col, tagline_col = st.columns([1, 2.7])
with brand_col:
    st.markdown("### 🎓 EduVault")
    st.caption("ACADEMIC INTELLIGENCE")
with tagline_col:
    st.markdown(
        "<div style='text-align:right;padding-top:8px;color:#a9b9d2'>"
        "Academic performance&nbsp;&nbsp; • &nbsp;&nbsp;Course outcomes&nbsp;&nbsp; • &nbsp;&nbsp;Learning insights"
        "</div>", unsafe_allow_html=True
    )

st.markdown("<div class='topnav-label'>WORKSPACE NAVIGATION</div>", unsafe_allow_html=True)
nav_cols = st.columns(5, gap="small")
for nav_col, nav_page in zip(nav_cols, pages):
    with nav_col:
        if st.button(
            nav_page,
            key=f"nav_{nav_page}",
            type="primary" if st.session_state.eduvault_page == nav_page else "secondary",
            use_container_width=True
        ):
            st.session_state.eduvault_page = nav_page
            st.rerun()

page = st.session_state.eduvault_page
st.divider()

# ---------- PAGE INTRO ----------
st.markdown("""
<div class="hero">
  <div class="eyebrow">Academic analytics workspace</div>
  <h1>EduVault</h1>
  <p>One view of academic performance, course outcomes, and student learning activity.</p>
</div>
""", unsafe_allow_html=True)

# ---------- CONNECTION STATUS ----------
pg_ok, mongo_ok = False, False
pg_error, mongo_error = None, None
try:
    c = get_postgres_connection()
    c.close()
    pg_ok = True
except Exception as e:
    pg_error = str(e)
try:
    get_mongo_database().command("ping")
    mongo_ok = True
except Exception as e:
    mongo_error = str(e)

c1, c2, c3 = st.columns([1, 1, 2])
with c1:
    st.metric("PostgreSQL", "Connected" if pg_ok else "Offline")
with c2:
    st.metric("MongoDB", "Connected" if mongo_ok else "Offline")
with c3:
    st.markdown(
        f'<div class="panel"><b>System status</b><br>'
        f'<span class="small-muted">{"Both data sources are responding." if pg_ok and mongo_ok else "Check the database connection before interpreting analytics."}</span></div>',
        unsafe_allow_html=True
    )
if not pg_ok:
    with st.expander("PostgreSQL connection error"):
        st.code(pg_error or "Unknown error")
if not mongo_ok:
    with st.expander("MongoDB connection error"):
        st.code(mongo_error or "Unknown error")
if not pg_ok:
    st.error("PostgreSQL is required for the academic pages. Check your .env settings and database service.")
    st.stop()

# ---------- LOAD DATA ----------
try:
    summary = get_student_summary()
    performance = get_student_performance()
    courses = get_course_outcomes()
    activities = get_activity_data() if mongo_ok else pd.DataFrame()
except Exception as e:
    st.error("Could not load EduVault data. Check your database tables and analytics queries.")
    st.exception(e)
    st.stop()

if activities.empty:
    activities = pd.DataFrame(columns=[
        "student_id", "course_code", "activity_type", "content_id",
        "duration_minutes", "completion_percentage", "timestamp"
    ])

# Coerce numeric fields safely.
for col in ["marks", "grade_point"]:
    if col in performance.columns:
        performance[col] = pd.to_numeric(performance[col], errors="coerce")
for col in ["average_marks", "students_enrolled", "highest_marks", "lowest_marks"]:
    if col in courses.columns:
        courses[col] = pd.to_numeric(courses[col], errors="coerce")
if "completion_percentage" in activities.columns:
    activities["completion_percentage"] = pd.to_numeric(
        activities["completion_percentage"], errors="coerce"
    )
if "duration_minutes" in activities.columns:
    activities["duration_minutes"] = pd.to_numeric(
        activities["duration_minutes"], errors="coerce"
    )

# Only logs whose student_id exists in PostgreSQL are linked student activity.
known_ids = set(summary["student_id"].dropna().tolist()) if "student_id" in summary else set()
if "student_id" in activities.columns:
    linked_activities = activities[activities["student_id"].isin(known_ids)].copy()
    unlinked_count = len(activities) - len(linked_activities)
else:
    linked_activities = activities.iloc[0:0].copy()
    unlinked_count = len(activities)

total_students = int(summary["student_id"].nunique()) if "student_id" in summary else 0
total_courses = int(courses["course_id"].nunique()) if "course_id" in courses else 0
total_enrollments = int(performance["student_id"].count()) if "student_id" in performance else 0
avg_marks = float(performance["marks"].mean()) if not performance.empty and "marks" in performance else 0.0
activity_count = len(activities)

# Shared plot style.
def style_chart(fig, height=390):
    fig.update_layout(
        template="plotly_dark",
        height=height,
        paper_bgcolor="rgba(0,0,0,0)",
        plot_bgcolor="rgba(0,0,0,0)",
        font=dict(color="#dce6f7", family="Arial"),
        margin=dict(l=18, r=18, t=60, b=25),
        title_font=dict(size=17, color="#f4f7ff"),
        legend_title_text="",
        hoverlabel=dict(bgcolor="#111b2d", font_color="#f4f7ff")
    )
    fig.update_xaxes(gridcolor="#27344b", zerolinecolor="#27344b")
    fig.update_yaxes(gridcolor="#27344b", zerolinecolor="#27344b")
    return fig

def section(title, note):
    st.markdown(f'<div class="section-title">{title}</div><div class="section-note">{note}</div>', unsafe_allow_html=True)

def metric_row():
    a, b, c, d = st.columns(4)
    a.metric("Students", f"{total_students:,}")
    b.metric("Courses", f"{total_courses:,}")
    c.metric("Course-grade records", f"{total_enrollments:,}")
    d.metric("Average marks", f"{avg_marks:.1f}/100")

# ---------- OVERVIEW ----------
if page == "Overview":
    section("Overview", "A live snapshot of academic records and learning participation.")
    metric_row()
    st.write("")
    left, right = st.columns(2)
    with left:
        if not summary.empty and "average_marks" in summary.columns:
            chart_data = summary.dropna(subset=["average_marks"]).nlargest(15, "average_marks")
            fig = px.bar(chart_data, x="student_name", y="average_marks",
                         title="Top 15 students by average marks",
                         labels={"student_name": "Student", "average_marks": "Average marks"},
                         text_auto=".1f", color="average_marks",
                         color_continuous_scale=["#2dd4bf", "#818cf8", "#c084fc"])
            st.plotly_chart(style_chart(fig), use_container_width=True)
        else:
            st.info("No graded student records are available yet.")
    with right:
        if not courses.empty and "average_marks" in courses.columns:
            cd = courses.dropna(subset=["average_marks"]).sort_values("average_marks", ascending=True)
            fig = px.bar(cd, x="average_marks", y="course_name", orientation="h",
                         title="Average marks by course",
                         labels={"course_name": "Course", "average_marks": "Average marks"},
                         text_auto=".1f", color="average_marks",
                         color_continuous_scale=["#38bdf8", "#818cf8", "#c084fc"])
            st.plotly_chart(style_chart(fig), use_container_width=True)
        else:
            st.info("No course outcome data is available.")
    section("Academic records", "Each row represents one student-course enrollment with its own grade.")
    st.dataframe(performance, use_container_width=True, hide_index=True)
    section("Learning activity", "MongoDB logs are linked to PostgreSQL students by student_id.")
    m1, m2, m3 = st.columns(3)
    m1.metric("All MongoDB logs", f"{activity_count:,}")
    m2.metric("Linked logs", f"{len(linked_activities):,}")
    m3.metric("Unlinked legacy logs", f"{unlinked_count:,}")
    if not linked_activities.empty and "activity_type" in linked_activities:
        counts = linked_activities["activity_type"].fillna("Unknown").value_counts().rename_axis("activity_type").reset_index(name="events")
        fig = px.pie(counts, names="activity_type", values="events", hole=.58, title="Activity mix")
        st.plotly_chart(style_chart(fig, 350), use_container_width=True)

# ---------- STUDENT PERFORMANCE ----------
elif page == "Student Performance":
    section("Student performance", "Filter the academic results by department and inspect individual course grades.")
    departments = ["All departments"] + sorted(summary["department_name"].dropna().astype(str).unique().tolist())
    selected_department = st.selectbox("Department", departments)
    filtered_summary = summary.copy()
    filtered_perf = performance.copy()
    if selected_department != "All departments":
        filtered_summary = filtered_summary[filtered_summary["department_name"] == selected_department]
        filtered_perf = filtered_perf[filtered_perf["department_name"] == selected_department]
    a, b, c = st.columns(3)
    a.metric("Students shown", f"{filtered_summary['student_id'].nunique():,}")
    b.metric("Graded records", f"{len(filtered_perf):,}")
    c.metric("Average marks", f"{filtered_perf['marks'].mean():.1f}" if not filtered_perf.empty else "—")
    if not filtered_summary.empty:
        fig = px.histogram(filtered_summary, x="average_marks", nbins=15,
                           title="Distribution of student averages",
                           labels={"average_marks": "Average marks"},
                           color_discrete_sequence=["#818cf8"])
        st.plotly_chart(style_chart(fig), use_container_width=True)
    st.dataframe(filtered_summary, use_container_width=True, hide_index=True)
    st.download_button("Download student summary CSV", filtered_summary.to_csv(index=False).encode("utf-8"),
                       "eduvault_student_summary.csv", "text/csv")

# ---------- COURSE OUTCOMES ----------
elif page == "Course Outcomes":
    section("Course outcomes", "Compare enrollment volume and marks across the available courses.")
    if not courses.empty:
        a, b, c = st.columns(3)
        a.metric("Courses", f"{total_courses:,}")
        b.metric("Total enrollments", f"{int(courses['students_enrolled'].fillna(0).sum()):,}")
        c.metric("Mean course average", f"{courses['average_marks'].mean():.1f}" if courses["average_marks"].notna().any() else "—")
        fig = px.bar(courses.sort_values("average_marks", ascending=False),
                     x="course_code", y="average_marks", color="students_enrolled",
                     title="Course averages and enrollment volume",
                     labels={"course_code": "Course code", "average_marks": "Average marks",
                             "students_enrolled": "Enrollments"},
                     text_auto=".1f", color_continuous_scale=["#38bdf8", "#818cf8", "#c084fc"])
        st.plotly_chart(style_chart(fig), use_container_width=True)
        st.dataframe(courses, use_container_width=True, hide_index=True)
        st.download_button("Download course outcomes CSV", courses.to_csv(index=False).encode("utf-8"),
                           "eduvault_course_outcomes.csv", "text/csv")
    else:
        st.info("No courses found.")

# ---------- LEARNING ACTIVITY ----------
elif page == "Learning Activity":
    section("Learning activity", "Behavioral events come from MongoDB. Student-level insights use only matching PostgreSQL IDs.")
    a, b, c, d = st.columns(4)
    a.metric("All activity logs", f"{activity_count:,}")
    b.metric("Linked activity logs", f"{len(linked_activities):,}")
    c.metric("Learning minutes", f"{int(linked_activities['duration_minutes'].fillna(0).sum()):,}" if "duration_minutes" in linked_activities else "0")
    d.metric("Mean completion", f"{linked_activities['completion_percentage'].mean():.1f}%" if "completion_percentage" in linked_activities and linked_activities["completion_percentage"].notna().any() else "—")
    if unlinked_count:
        st.warning(f"{unlinked_count} existing log(s) do not match a current PostgreSQL student ID. They are preserved, but excluded from linked student analysis.")
    if not linked_activities.empty:
        left, right = st.columns(2)
        with left:
            if "activity_type" in linked_activities:
                counts = linked_activities["activity_type"].fillna("Unknown").value_counts().rename_axis("activity_type").reset_index(name="events")
                fig = px.bar(counts, x="activity_type", y="events", title="Events by activity type",
                             text_auto=True, color="events",
                             color_continuous_scale=["#38bdf8", "#818cf8", "#c084fc"])
                st.plotly_chart(style_chart(fig), use_container_width=True)
        with right:
            if "course_code" in linked_activities:
                counts = linked_activities.groupby("course_code").size().reset_index(name="events")
                fig = px.bar(counts, x="course_code", y="events", title="Learning activity by course",
                             text_auto=True, color_discrete_sequence=["#2dd4bf"])
                st.plotly_chart(style_chart(fig), use_container_width=True)
        st.dataframe(linked_activities.sort_values("timestamp", ascending=False) if "timestamp" in linked_activities else linked_activities,
                     use_container_width=True, hide_index=True)
        st.download_button("Download linked activity CSV", linked_activities.to_csv(index=False).encode("utf-8"),
                           "eduvault_linked_activity.csv", "text/csv")
    else:
        st.info("No linked learning activity is available. Run bulk_load_data.py to create linked demo activity.")

# ---------- STUDENT EXPLORER ----------
elif page == "Student Explorer":
    section("Student explorer", "Choose a student to view all course enrollments, grades and linked learning activity.")
    if summary.empty:
        st.info("No student records are available.")
    else:
        options = summary[["student_id", "student_name", "roll_number", "department_name"]].copy()
        options["display"] = options["student_name"].astype(str) + " · " + options["roll_number"].astype(str)
        selected_display = st.selectbox("Select student", options["display"].tolist())
        chosen = options[options["display"] == selected_display].iloc[0]
        sid = chosen["student_id"]
        student_row = summary[summary["student_id"] == sid].iloc[0]
        student_courses = performance[performance["student_id"] == sid].copy()
        student_activities = linked_activities[linked_activities["student_id"] == sid].copy() if "student_id" in linked_activities else linked_activities.iloc[0:0]
        x1, x2, x3, x4 = st.columns(4)
        x1.metric("Department", str(student_row["department_name"]))
        x2.metric("Courses graded", f"{student_courses['course_id'].nunique()}" if "course_id" in student_courses else f"{len(student_courses)}")
        x3.metric("Average marks", f"{student_courses['marks'].mean():.1f}" if not student_courses.empty else "—")
        x4.metric("Learning events", f"{len(student_activities):,}")
        if not student_courses.empty:
            fig = px.bar(student_courses, x="course_code", y="marks", color="marks",
                         title=f"Course marks · {chosen['student_name']}",
                         labels={"course_code": "Course", "marks": "Marks"},
                         text_auto=True, color_continuous_scale=["#38bdf8", "#818cf8", "#c084fc"])
            st.plotly_chart(style_chart(fig), use_container_width=True)
            st.markdown("#### Course transcript")
            st.dataframe(student_courses, use_container_width=True, hide_index=True)
        else:
            st.info("This student does not have graded course records yet.")
        st.markdown("#### Learning activity")
        if not student_activities.empty:
            st.dataframe(student_activities, use_container_width=True, hide_index=True)
        else:
            st.info("No linked MongoDB activity is recorded for this student yet.")

st.markdown("""
<div class="footer">
  EduVault · Academic Information & Analytics Platform<br>
  PostgreSQL · MongoDB · Python · Pandas · Plotly · Streamlit
</div>
""", unsafe_allow_html=True)