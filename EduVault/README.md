# EduVault — Setup Guide

EduVault is an academic information and analytics dashboard using
PostgreSQL, MongoDB, Python, Streamlit, Pandas, and Plotly.

## 1. Clone the repository

```bash
git clone https://github.com/udayreddytetali/EduVault.git
cd EduVault
```

## 2. Install prerequisites

Install Python 3, PostgreSQL, MongoDB Community Server, and MongoDB
Database Tools (which provide `mongoimport`).

On macOS, install the tools using the official installers or Homebrew.
Make sure both database services are running.

## 3. Configure environment variables

```bash
cp .env.example .env
```

Open `.env` and fill in your local PostgreSQL username and password.
Never commit `.env` or share real passwords.

The default MongoDB URI in this example is `mongodb://localhost:27017`.
Change it if your local MongoDB server uses a different port.

## 4. Restore PostgreSQL

Create an empty database named `eduvault` first.

```bash
createdb -U postgres eduvault
```

If your PostgreSQL username is not `postgres`, replace it with your
username. You may be prompted for a password.

Then run:

```bash
bash postgresql/setup/restore.sh
```

This imports the included PostgreSQL SQL backup into the empty database.
Do not run it against a database that already contains EduVault tables.

## 5. Import MongoDB data

The six JSON exports are in `mongodb/data/`.

Run the import script from the repository root:

```bash
bash mongodb/setup/import_all.sh
```

The script imports all six collections into `eduvault_mongo`.
It uses `--drop`, so each target collection is replaced. Use it only
for a fresh/demo setup, not a database containing data you want to keep.

If MongoDB Compass exported JSON Lines rather than a JSON array and
`mongoimport` reports a JSON-array error, remove `--jsonArray` from the
corresponding command in the script and try again.

## 6. Install Python dependencies

```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install -r requirements.txt
```

## 7. Run the dashboard

Ensure `.env` contains the correct connection details for both databases.
Then run:

```bash
streamlit run app.py
```

## Repository guide

- `app.py` — Streamlit application entry point.
- `pages/` — dashboard pages.
- `analytics/` — analytics modules.
- `database/postgres_db.py` — PostgreSQL connection code.
- `database/mongo_db.py` — MongoDB connection code.
- `postgresql/EduVault_backup.sql` — PostgreSQL backup.
- `postgresql/setup/restore.sh` — PostgreSQL restore helper.
- `mongodb/data/` — exported MongoDB collections.
- `mongodb/setup/import_all.sh` — MongoDB import helper.
- `docs/` — earlier project documentation.
- `.env.example` — safe configuration template.

## Important notes

- The SQL backup and JSON exports are demo snapshots.
- PostgreSQL and MongoDB must be restored from the matching exports
  for linked student IDs to remain consistent.
- Collection validators and indexes may need separate recreation if
  they were not included in the exports.
- Never commit `.env`, passwords, or other private credentials.
