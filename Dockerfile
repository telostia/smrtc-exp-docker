FROM node:latest

ENV EXPLORER_VERSION v1.7.2


RUN apt-get update && \
    apt-get --no-install-recommends --yes install \
    git \
    supervisor \
    cron \
    nano \
    rsyslog && \
    rm -rf /var/lib/apt/lists/* && apt-get clean

ADD entrypoint.sh entrypoint.sh

WORKDIR /explorer

ENV UPDATES V8

RUN git clone https://github.com/telostia/smrtc-exp.git . && \
   # git checkout $EXPLORER_VERSION && \
    mkdir /explorer/settings && \
    ln -s /explorer/settings/settings.json /explorer/settings.json &&\
    npm install --production && \
    chmod +x  /entrypoint.sh && \
    sed -i -e 's/\r$//' /entrypoint.sh
    

VOLUME ["/explorer/settings"]

COPY supervisord.conf /etc/supervisord.conf


ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]