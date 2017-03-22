FROM alpine:latest
LABEL maintainer "strebulaev@gmail.com"

ENV VERSION 4.5.0.5

EXPOSE 3478 3478/udp

CMD "/usr/local/bin/turnserver"

RUN \
	apk add --no-cache --virtual .build \
		curl \
		openssl-dev \
		libevent-dev \
		hiredis-dev \
		g++ \
		make \
		linux-headers \
	&& \
	apk add --no-cache \
		libcrypto1.0 \
		libssl1.0 \
		libevent \
		libstdc++ \
		hiredis \
	&& \
	curl -OL http://turnserver.open-sys.org/downloads/v${VERSION}/turnserver-${VERSION}.tar.gz  && \
	tar -zxf turnserver-* && \
	cd turnserver-* && \
	CC=g++ ./configure && \
	make && \
	make install && \
	make clean && \
	rm -rf ../turnserver-* && \
	apk del .build