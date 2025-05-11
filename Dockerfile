# Bước 1: Chọn Base Image (Ảnh nền)
# Sử dụng image Node.js chính thức từ Docker Hub.
# Chọn phiên bản LTS (Long Term Support) gần nhất, dùng base Alpine Linux cho nhẹ.
FROM node:20-alpine
# Bạn có thể thay 18 bằng phiên bản LTS khác nếu muốn (vd: 20-alpine)

# Bước 2: Đặt Thư Mục Làm Việc (Working Directory) bên trong Container
# Tạo thư mục /app và chuyển vào đó. Các lệnh sau sẽ chạy trong thư mục này.
WORKDIR /app

# Bước 3: Sao Chép File package.json (và package-lock.json nếu có)
# Copy file quản lý dependencies vào trước.
# Tối ưu caching: Bước này chỉ chạy lại nếu file package*.json thay đổi.
COPY package*.json ./

# Bước 4: Cài Đặt Dependencies
# Chạy npm install bên trong image để cài các thư viện cần thiết.
# Lớp này sẽ được cache và chỉ chạy lại nếu bước COPY package*.json ở trên chạy lại.
RUN npm install
# Lưu ý: Trong thực tế có thể dùng `RUN npm ci --only=production` để cài đặt nhanh hơn và chỉ cài production dependencies. Nhưng để đơn giản, ta dùng `npm install`.

# Bước 5: Sao Chép Toàn Bộ Source Code
# Copy code của ứng dụng (server.js và các file khác nếu có) vào thư mục /app.
# Copy sau khi npm install để tận dụng cache. Bước này chạy lại khi code thay đổi,
# nhưng không cần chạy lại npm install nếu package.json không đổi.
COPY . .

# Bước 6: Expose Port (Thông báo cổng ứng dụng lắng nghe)
# Khai báo rằng ứng dụng bên trong container sẽ lắng nghe ở port 3000.
# Lưu ý: Bước này chỉ là thông tin, chưa thực sự mở port ra máy host.
EXPOSE 3000

# Bước 7: Lệnh Khởi Chạy Container (Default Command)
# Chỉ định lệnh sẽ được thực thi khi container khởi động từ image này.
# Dùng dạng JSON array ["executable", "param1", ...] là best practice.
CMD [ "npm", "start" ]
# Hoặc có thể dùng CMD [ "npm", "start" ] nếu bạn đã định nghĩa script "start" trong package.json