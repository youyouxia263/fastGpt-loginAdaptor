FROM nginx:stable-alpine
WORKDIR /app
# 复制构建产物到Nginx目录
COPY ./dist /usr/share/nginx/html

# 暴露80端口
EXPOSE 80

# 启动Nginx
CMD ["nginx", "-g", "daemon off;"]
