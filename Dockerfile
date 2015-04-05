FROM rudijs/rsm-iojs:0.0.1
MAINTAINER Ride Share Market "systemsadmin@ridesharemarket.com"

# NPM package cache
ENV NPM_REFRESHED_AT 2015-04-05.1
COPY package.json /tmp/package.json
RUN \
    cd /tmp && \
    npm install --production && \
    npm install -g pm2 && \
    npm cache clean

# Application
ENV APP_REFRESHED_AT 2015-04-05.1
ENV APP_DIR /srv/ride-share-market-data
RUN \
    mkdir ${APP_DIR} && \
    cp -a /tmp/node_modules/ ${APP_DIR} && \
    mkdir ${APP_DIR}/log && \
    mkdir ${APP_DIR}/pids
COPY app/ ${APP_DIR}/app
COPY config/ ${APP_DIR}/config
COPY app-rpc-consumer-mongodb.js ${APP_DIR}/app-rpc-consumer-mongodb.js
COPY package.json ${APP_DIR}/package.json

# Application User
RUN \
    useradd -c 'RSM Data' -u 2000 -m -d /home/rsm-data -s /bin/bash rsm-data && \
    chown -R rsm-data.rsm-data ${APP_DIR}

USER rsm-data

ENV HOME /home/rsm-data

# Export the APP_DIR as a data volume under the app user account.
# Other containers use this volume's data (eg. logstash, nginx).
VOLUME ${APP_DIR}

# Application Start
WORKDIR ${APP_DIR}

CMD ["pm2", "start", "config/processes-production.json", "--no-daemon"]
