FROM debian:jessie
MAINTAINER Stephon Chen <stephon@gmail.com>

# Redis app directory
WORKDIR /app/
COPY manage.sh /app/

# Install wget and install/updates certificates
RUN apt-get update \
 && apt-get install -y wget curl gcc tcl bash\
 && apt-get install -y libc6-dev \
 && apt-get install -y libjemalloc-dev build-essential 

# Build redis from source
RUN cd /tmp \
&& wget http://download.redis.io/releases/redis-3.0.5.tar.gz \
&& tar zxvf redis-3.0.5.tar.gz \
&& mv redis-3.0.5 redis \ 
&& cd redis \
&& cd deps \
&& make hiredis lua jemalloc linenoise \
&& cd .. \
&& make \
&& make install clean \
; sleep 1 ; rm /tmp/redis-3.0.5.tar.gz \
; apt-get -y remove build-essential gcc tcl \
; apt-get clean autoclean autoremove \
; mkdir /app/redis && cp /tmp/redis/redis.conf /app/redis/ \
; rm -rf /tmp/redis

ENV PORT 6379

ENTRYPOINT ["/app/manage.sh"]

CMD ["/bin/bash"]
