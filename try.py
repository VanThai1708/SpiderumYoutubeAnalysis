from sqlalchemy import create_engine, text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Kết nối đến cơ sở dữ liệu
engine = create_engine('postgresql://postgres:pthai332277@localhost:5432/youtube_api')

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
    result = session.execute(text("CALL test_to_fact()"))

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
