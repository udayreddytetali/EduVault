import os
import psycopg2
import pandas as pd
from dotenv import load_dotenv

load_dotenv()


def get_postgres_connection():
    return psycopg2.connect(
        host=os.getenv("POSTGRES_HOST"),
        port=int(os.getenv("POSTGRES_PORT", 5432)),
        database=os.getenv("POSTGRES_DB"),
        user=os.getenv("POSTGRES_USER"),
        password=os.getenv("POSTGRES_PASSWORD")
    )


def fetch_dataframe(query):
    conn = get_postgres_connection()

    try:
        return pd.read_sql_query(query, conn)
    finally:
        conn.close()