FROM debian:jessie

MAINTAINER Anthony K GROSS

RUN echo "deb http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list

RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y --force-yes deb-multimedia-keyring supervisor wget
RUN apt-get install -y --force-yes git gcc make libpcre3-dev libssl-dev ffmpeg --fix-missing
RUN rm -rf /var/lib/apt/lists/* && apt-get autoremove -y --purge

ENV YOUTUBE_URL rtmp://a.rtmp.youtube.com/live2
ENV YOUTUBE_STREAMKEY NULL

ENV TWITCH_URL rtmp://live-cdg.twitch.tv/app
ENV TWITCH_STREAMKEY NULL

ENV HITBOX_URL rtmp://live.hitbox.tv/push
ENV HITBOX_STREAMKEY NULL

ENV DAILYMOTION_URL rtmp://publish.dailymotion.com/publish-dm
ENV DAILYMOTION_STREAMKEY NULL

ENV YOUR_IP YOUR_IP
ENV PRIVATE_KEY anthonykgross
ENV STREAM_SPECIFIER hd720
ENV URL_TRANSCODE transcode
ENV URL_LIVE live


RUN mkdir /conf
ADD ./conf /conf

RUN mkdir nginx && \
	cd nginx && \
	git clone https://github.com/arut/nginx-rtmp-module && \
	wget http://nginx.org/download/nginx-1.4.3.tar.gz && \
	tar zxpvf nginx-1.4.3.tar.gz && \
	cd nginx-1.4.3 && \
	./configure --add-module=/nginx/nginx-rtmp-module/ --with-http_ssl_module --with-http_secure_link_module --prefix=/usr/local/nginx-streaming && \
    make && \
	make install

RUN cp /conf/nginx/nginx.conf /usr/local/nginx-streaming/conf/nginx.conf -f
RUN cp /conf/supervisor/conf.d/supervisor.conf /etc/supervisor/conf.d/supervisor.conf -f

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 8080
EXPOSE 1935

ENTRYPOINT ["/entrypoint.sh"]
