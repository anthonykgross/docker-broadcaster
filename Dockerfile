FROM anthonykgross/docker-base:latest

MAINTAINER Anthony K GROSS

RUN echo "deb http://ftp.uk.debian.org/debian jessie-backports main" >> /etc/apt/sources.list && \
    apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y supervisor wget && \
    apt-get install -y git gcc make libpcre3-dev libssl-dev ffmpeg && \
    rm -rf /var/lib/apt/lists/* && apt-get autoremove -y --purge

ENV YOUTUBE_URL rtmp://a.rtmp.youtube.com/live2
ENV YOUTUBE_STREAMKEY NULL

ENV TWITCH_URL rtmp://live-cdg.twitch.tv/app
ENV TWITCH_STREAMKEY NULL

ENV HITBOX_URL rtmp://live.hitbox.tv/push
ENV HITBOX_STREAMKEY NULL

ENV DAILYMOTION_URL rtmp://publish.dailymotion.com/publish-dm
ENV DAILYMOTION_STREAMKEY NULL

ENV LIVECODING_URL rtmp://eumedia1.livecoding.tv:1935/livecodingtv
ENV LIVECODING_STREAMKEY NULL

ENV YOUR_IP YOUR_IP
ENV PRIVATE_KEY anthonykgross
ENV STREAM_SPECIFIER hd720
ENV URL_TRANSCODE transcode
ENV URL_LIVE live
ENV EXPIRATION_TOKEN 3600

RUN mkdir -p /conf && \
    mkdir -p /log && \
    chmod 777 /log -Rf  && \
    mkdir nginx && \
	cd nginx && \
	git clone https://github.com/arut/nginx-rtmp-module && \
	wget http://nginx.org/download/nginx-1.12.0.tar.gz && \
	tar zxpvf nginx-1.12.0.tar.gz && \
	cd nginx-1.12.0 && \
	./configure --add-module=/src/nginx/nginx-rtmp-module --with-http_ssl_module --with-http_secure_link_module --prefix=/usr/local/nginx-streaming && \
    make && \
	make install && \
	rm /src/* -Rf

ADD ./conf /conf
ADD entrypoint.sh /entrypoint.sh

RUN cp /conf/nginx/nginx.conf /usr/local/nginx-streaming/conf/nginx.conf -f  && \
    cp /conf/supervisor/conf.d/supervisor.conf /etc/supervisor/conf.d/supervisor.conf -f && \
    chmod +x /entrypoint.sh

EXPOSE 80
EXPOSE 1935

ENTRYPOINT ["/entrypoint.sh"]
CMD ["run"]