#!/bin/bash
set -e

echo -n "anthonykgross/stream123456789" | openssl dgst -md5 -binary | openssl enc -base64 | tr '+/' '-_' | tr -d '='

mkdir nginx
cd nginx

git clone https://github.com/arut/nginx-rtmp-module

wget http://nginx.org/download/nginx-1.4.3.tar.gz
tar zxpvf nginx-1.4.3.tar.gz
cd nginx-1.4.3

./configure --add-module=/nginx/nginx-rtmp-module/ --with-http_ssl_module --with-http_secure_link_module --prefix=/usr/local/nginx-streaming
make
make install

cp /usr/local/nginx-streaming/conf/new-nginx.conf /usr/local/nginx-streaming/conf/nginx.conf -f

supervisord