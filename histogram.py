import psycopg2
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Kết nối với cơ sở dữ liệu PostgreSQL
conn = psycopg2.connect(
    host="localhost",
    database="youtube_api",
    user="postgres",
    password="pthai332277"
)

# Đọc dữ liệu từ bảng
query = "SELECT commnent_count FROM test"
df = pd.read_sql_query(query, conn)

# Đóng kết nối
conn.close()

# Giả sử dữ liệu của bạn nằm trong cột 'value_column' của DataFrame df
data = df['commnent_count']

# Vẽ biểu đồ histogram bằng matplotlib
# plt.hist(data, bins=30, alpha=0.7, color='blue', edgecolor='black')
# plt.title('Histogram of Value Column')
# plt.xlabel('Value')
# plt.ylabel('Frequency')
# plt.show()

# Hoặc vẽ biểu đồ histogram bằng seaborn
sns.histplot(data, bins=30, kde=True, color='blue')
plt.title('Histogram of Value Column')
plt.xlabel('Value')
plt.ylabel('Frequency')
plt.show()
