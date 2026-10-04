from database.mongo_db import get_mongo_database
import pandas as pd


def get_activity_data():
    db = get_mongo_database()

    collection = db["activity_logs"]

    data = list(collection.find({}, {"_id": 0}))

    return pd.DataFrame(data)


def get_activity_count():
    db = get_mongo_database()

    return db["activity_logs"].count_documents({})