
from database.mongo_db import get_mongo_database

db = get_mongo_database()

for name in ["learning_content", "activity_logs"]:
    collection = db[name]

    print(f"\n--- {name} ---")
    print("Total records:", collection.count_documents({}))

    for doc in collection.find({}, {"_id": 0}).limit(2):
        print("Fields:", list(doc.keys()))
        print("Sample:", doc)