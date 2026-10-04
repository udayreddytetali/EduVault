# EduVault – Academic Information & Analytics Platform

## Project Overview

EduVault is an academic information and analytics platform that combines relational and NoSQL databases to manage academic information, learning content, and student activity.

The project integrates PostgreSQL, MongoDB, Python, Pandas, and Streamlit to provide academic performance and learning activity analytics through an interactive dashboard.

## Technologies Used

* PostgreSQL – Structured academic data
* MongoDB – Learning content and student activity data
* Python – Application and database integration
* Pandas – Data analysis and processing
* Streamlit – Interactive dashboard
* Plotly – Data visualization
* PyMongo – MongoDB connectivity
* Psycopg2 – PostgreSQL connectivity
* Git/GitHub – Version control

## Database Architecture

### PostgreSQL

PostgreSQL stores structured academic information:

* Departments
* Students
* Instructors
* Courses
* Enrollments
* Grades
* Student Languages
* Student Certifications
* Course Prerequisites

The database uses primary keys, foreign keys, unique constraints, check constraints, and normalized relational structures.

### MongoDB

MongoDB stores flexible and activity-oriented data:

* Learning content
* Student activity logs

MongoDB features implemented in the project include:

* CRUD operations
* Embedded documents
* References
* Polymorphic pattern
* Bucket pattern
* Indexing
* Aggregation
* Schema validation
* Replica set
* Transactions

## Analytics

The Python analytics layer retrieves data from PostgreSQL and MongoDB and processes it using Pandas.

Implemented analytics include:

* Student performance
* Average marks
* Course outcomes
* Enrollment information
* Highest and lowest marks
* Learning activity information

## Dashboard

The Streamlit dashboard provides:

* Database connection status
* Academic overview
* Student performance analysis
* Course outcome analysis
* Learning activity analysis
* Individual student details
* Interactive Plotly visualizations

## Project Structure

```text
EduVault/
│
├── app.py
├── requirements.txt
├── README.md
├── .env
├── .gitignore
│
├── database/
│   ├── __init__.py
│   ├── postgres_db.py
│   └── mongo_db.py
│
├── analytics/
│   ├── __init__.py
│   ├── student_analysis.py
│   ├── course_analysis.py
│   └── activity_analysis.py
│
└── pages/
```

## Running the Project

### 1. Activate the virtual environment

```bash
venv\Scripts\activate #virtual environment 
```

### 2. Install dependencies

```bash
pip install -r requirements.txt
```

### 3. Configure environment variables

Create a `.env` file containing the PostgreSQL and MongoDB connection details.

The `.env` file should not be uploaded to GitHub.

### 4. Start the Streamlit application

```bash
streamlit run app.py
```

The dashboard will open in the browser.

## Database Integration

The project follows this architecture:

```text
PostgreSQL ──────┐
                 │
                 ▼
              Python
                 │
              Pandas
                 │
MongoDB ─────────┘
                 │
                 ▼
             Streamlit
                 │
                 ▼
          Plotly Dashboard
```

## Security

Database credentials are stored in environment variables and excluded from version control using `.gitignore`.

## Project Objective

The objective of EduVault is to demonstrate how relational and NoSQL databases can be integrated with Python-based analytics to build an academic information and decision-support platform.
