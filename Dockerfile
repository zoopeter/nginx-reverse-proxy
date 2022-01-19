#Dockerfile
FROM nginx:latest

COPY config/nginx.conf /etc/nginx/nginx.conf
COPY config/conf.d/*.conf /etc/nginx/conf.d/*.conf

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 8080
