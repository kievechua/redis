FROM ubuntu:trusty
MAINTAINER Fernando Mayo <fernando@tutum.co>

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv C7917B12 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y redis-server pwgen sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Change the docker default timezone from UTC to KLT
USER root
RUN sudo echo "Asia/Kuala_Lumpur" > /etc/timezone
RUN sudo dpkg-reconfigure -f noninteractive tzdata

# Add scripts
ADD run.sh /run.sh

ENV REDIS_PASS **Random**
ENV REDIS_DIR /data
VOLUME ["/data"]

EXPOSE 6379
CMD ["/run.sh"]
