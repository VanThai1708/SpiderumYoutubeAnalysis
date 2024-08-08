import psycopg2
from utils.config import DATABASE_CONFIG
from sqlalchemy import create_engine, text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

def connect_to_postgres():
    conn_string = f"postgresql://{DATABASE_CONFIG['user']}:{DATABASE_CONFIG['password']}@{DATABASE_CONFIG['host']}/{DATABASE_CONFIG['database']}"
    db = create_engine(conn_string)
    conn = db.connect()

    return conn, 