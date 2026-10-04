import os
from pymongo import MongoClient
from dotenv import load_dotenv  #enivroments variables are stored in .env file and we can access them using load_dotenv()
# function our passord and other sensitive information is stored in .env file and we can access them using load_dotenv() function our password and all stored here 

load_dotenv()


def get_mongo_database():
    client = MongoClient(os.getenv("MONGO_URI"))
    return client[os.getenv("MONGO_DB")]