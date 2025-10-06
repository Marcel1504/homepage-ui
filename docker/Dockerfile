FROM nginx:alpine

COPY /docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY /build/web /usr/share/nginx/html
COPY /docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]