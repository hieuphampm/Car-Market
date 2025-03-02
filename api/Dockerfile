# Sử dụng Node.js phiên bản LTS
FROM node:18-alpine

# Thiết lập thư mục làm việc trong container
WORKDIR /app

# Sao chép package.json và package-lock.json trước để cài đặt dependencies
COPY package*.json ./

# Cài đặt các dependencies
RUN npm install --production

# Sao chép toàn bộ mã nguồn vào container
COPY . .

# Expose cổng 3000
EXPOSE 4000

# Lệnh chạy ứng dụng
CMD ["node", "index.js"]
