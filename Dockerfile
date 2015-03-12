# Version: 0.0.1
FROM ubuntu:14.04
MAINTAINER Ride Share Market "systemsadmin@ridesharemarket.com"

# APT cache
ENV APT_REFRESHED_AT 2015-03-07
RUN apt-get -qq update

# Required packages
RUN apt-get -y install wget

# Install io.js
RUN wget https://iojs.org/dist/v1.4.3/iojs-v1.4.3-linux-x64.tar.gz
RUN tar -C /usr/local/lib -zxvf iojs-v1.4.3-linux-x64.tar.gz
RUN ln -s /usr/local/lib/iojs-v1.4.3-linux-x64/bin/iojs /usr/local/bin/iojs
RUN ln -s /usr/local/lib/iojs-v1.4.3-linux-x64/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/iojs-v1.4.3-linux-x64/bin/npm /usr/local/bin/npm

# NPM package cache
ENV NPM_REFRESHED_AT 2015-03-13.1
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN npm install -g pm2

# Application
ENV APP_REFRESHED_AT 2015-03-10.4
RUN mkdir /srv/ride-share-market-data
RUN cp -a /tmp/node_modules/ /srv/ride-share-market-data
RUN mkdir /srv/ride-share-market-data/pids
ADD app/ /srv/ride-share-market-data/app
ADD config/ /srv/ride-share-market-data/config
ADD app-rpc-consumer-mongodb.js /srv/ride-share-market-data/app-rpc-consumer-mongodb.js
ADD package.json /srv/ride-share-market-data/package.json

# Application User
RUN useradd -c 'RSM Data' -u 2000 -m -d /home/rsm-data -s /bin/bash rsm-data
RUN chown -R rsm-data.rsm-data /srv/ride-share-market-data
USER rsm-data
ENV HOME /home/rsm-data

# Application Start
WORKDIR /srv/ride-share-market-data
CMD ["pm2", "start", "config/processes-production.json", "--no-daemon"]
