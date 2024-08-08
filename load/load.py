import psycopg2
from utils.config import DATABASE_CONFIG
from sqlalchemy import create_engine, text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker


def load(df):
    conn_string = f"postgresql://{DATABASE_CONFIG['user']}:{DATABASE_CONFIG['password']}@{DATABASE_CONFIG['host']}/{DATABASE_CONFIG['database']}"
    engine = create_engine(conn_string)
    conn = engine.connect()
    # Insert du lieu
    table_name = 'test'
    df.to_sql(table_name, con=conn, if_exists='append', index=False)

    # Call procedure
    # Khai báo lớp model base
    Base = declarative_base()

    # Định nghĩa lớp model cho thủ tục (nếu cần)
    # Ví dụ:
    # class MyProcedure(Base):
    #     __tablename__ = 'my_procedure'

    # Tạo session
    Session = sessionmaker(bind=engine)
    session = Session()

    try:
        # Gọi stored procedure
        result1 = session.execute(text("CALL main_procedure()"))
        result2 = session.execute(text("CALL test_to_fact()"))

        # Lấy kết quả nếu cần
        # for row in result:
        #     print(row)

        # Commit (nếu cần)
        session.commit()

        print("Stored procedure được gọi thành công.")

    except Exception as e:
        print(f"Có lỗi xảy ra: {e}")

    finally:
        # Đóng session
        session.close()




