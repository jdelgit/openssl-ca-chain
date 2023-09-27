FROM nginx:latest

COPY server/LocalServer0/certs/ca-chain.crt /ssl/ca-chain.crt
COPY server/LocalServer0/private/LocalServer0.key /ssl/server.key
COPY images/nginx/index.html /var/www/html/
COPY images/nginx/default.conf /etc/nginx/conf.d/

