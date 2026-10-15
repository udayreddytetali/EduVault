EDUVAULT UPDATE PACK

Files:
- app.py: replace your current project app.py with this updated dark dashboard.
- bulk_load_data.py: safely adds synthetic academic and MongoDB activity data.

Before running:
1. Keep your current .env and database/ and analytics/ folders.
2. Make a backup of your existing app.py.
3. In the activated project terminal run:
   python bulk_load_data.py
4. When it says DONE, run:
   streamlit run app.py

What the data script does:
- Adds 100 synthetic students using unique EV26 roll numbers.
- Adds one enrollment and grade per available course for each generated student.
- Adds certification/language rows.
- Adds one learning material per actual course.
- Adds 10 MongoDB activity events per generated student using actual PostgreSQL student IDs.
- Preserves existing records; on rerun it avoids duplicate PostgreSQL rows and replaces only MongoDB records marked generated_by=eduvault_bulk_v1.
- Data is fictional demo data, not real student records.

Notes:
- No schema change is required for the known schema.
- The dashboard reports unmatched legacy MongoDB activity separately rather than pretending it belongs to a current student.
- Keep .env private; do not upload credentials to GitHub.
