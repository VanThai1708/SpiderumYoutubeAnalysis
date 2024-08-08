# Các nội dung
- [Giới thiệu](#Giới-thiệu)
- [Cấu trúc project](#Cấu-trúc-project)
- [Các bước cài đặt](#Các-bước-cài-đặt)

## Giới thiệu
### Tổng quan
#### Quá trình thu thập dữ liệu
- Sử dụng Youtube Data API v3 để lấy dữ liệu từ kênh youtube [Spiderum](https://www.youtube.com/@Spiderum). Dữ liệu bao gồm tên video, thời lượng, thời gian đăng, lượt view, lượt thích, lượt bình luận,...
- Dữ liệu thu thập được sẽ được đổ vào bảng trong cơ sở dữ liệu PostgresSQL bằng thư viện psycopg2 của Python.

#### Quá trình etl dữ liệu
- Dữ liệu sau khi được crawl về sẽ được lưu trữ tại vùng stagging.
- Xây dựng các procedure để biến đổi dữ liệu, sau đó mapping dữ liệu các cột cần phân tích về dạng id.
- Đổ dữ liệu sau khi đã biến đổi về bảng fact, sau đó xây dựng các bảng dim tương ứng theo mô hình OLAP hình sao.

#### Xây dựng dashboard
- Sử dụng PowerBI để kết nối trực tiếp với dữ liệu trong PostgreSQL và tạo dashboard.

### Kết quả đạt được
<table width="100%"> 
<tr>
<td width="50%">      
&nbsp; 
<br>
<p align="center">
  Báo cáo tổng quan
</p>
<img width="632" alt="tongquan_y" src="https://github.com/user-attachments/assets/8a628b43-f973-44d9-b7cf-838c2421569a">
</td> 
<td width="50%">
<br>
<p align="center">
  Báo cáo hoạt động
</p>
<img width="635" alt="hoatdong_y" src="https://github.com/user-attachments/assets/b8839ba0-625d-45fb-929d-51a9584aa878">
</td>
</table>

## Cấu trúc project
- Thư mục utils thực hiện việc xác thực OAuth 2.0 trước khi sử dụng được API, ngoài ra còn bao gồm thông tin cấu hình database, cũng như thực hiện kết nối với cơ sở dữ liệu và gửi email thông báo khi thu thập dữ liệu thành công.
- Thư mục extract thực hiện việc trích xuất dữ liệu.
- Thư mục load thực hiện việc tải dữ liệu vào database.
- File main.py thực hiện trích xuất dữ liệu qua API, load dữ liệu vào database và gửi email thông báo.
- File procedure.sql chứa các procedure để biến đổi dữ liệu.
- File table.sql chứa các câu lệnh để tạo bảng vùng stagging, và các bảng dim, fact.
- File output.csv chứa dữ liệu thu thập.
- File requirements.txt chứa các thư viện cần cài đặt.
- File spiderum_youtube.pbix chạy trên PowerBI desktop để trực quan hóa dữ liệu.

## Các bước cài đặt
--> Clone repo:
```bash
git clone https://github.com/Thai1708/Analysis-Spiderum-Youtube-Channel.git

```

--> Tạo một virtual environment :
```bash
# Let's install virtualenv first
pip install virtualenv

# Then we create our virtual environment
virtualenv envname

```

--> Kích hoạt virtual environment :
```bash
envname\scripts\activate

```

--> Cài đặt các thư viện cần thiết :
```bash
pip install -r requirements.txt

```
--> Cài đặt các table trong file table.sql bằng PostgreSQL.

--> Cài đặt các procedure trong file procedure.sql bằng PostgreSQL.

--> Tạo một dự án trên Google Developers Console.

--> Kích hoạt YouTube Data API v3 cho dự án.

--> Chạy file main.py
