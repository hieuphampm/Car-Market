# Sử dụng Node.js phiên bản mới nhất
FROM node:18

# Thiết lập thư mục làm việc
WORKDIR /app

# Copy file package.json và package-lock.json trước
COPY package*.json ./

# Cài đặt các dependency
RUN npm install

# Copy toàn bộ code vào container
COPY . .

# Mở cổng 3000 cho API
EXPOSE 3000

# Chạy server
CMD ["node", "index.js"]
