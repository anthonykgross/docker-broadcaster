FROM debian:jessie

MAINTAINER Anthony K GROSS

RUN echo "deb http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list
RUN echo "deb-src http://www.deb-multimedia.org jessie main non-free" >> /etc/apt/sources.list

RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y --force-yes deb-multimedia-keyring supervisor wget

RUN apt-get install -y --force-yes git gcc make libpcre3-dev libssl-dev ffmpeg

RUN rm -rf /var/lib/apt/lists/* && apt-get autoremove -y --purge

EXPOSE 80
EXPOSE 443

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]