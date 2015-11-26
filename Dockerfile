FROM resin/rpi-raspbian

MAINTAINER Nic Burkinshaw <nicbkw@outlook.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    git \
    libmysqlclient-dev \
    ruby-rails \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/

# thingspeak SETUP
RUN git clone https://github.com/iobridge/thingspeak.git
WORKDIR /opt/thingspeak
RUN bundle install

# DB setup
ADD database.yml config/database.yml

# add user thingspeak to image
RUN groupadd -r thingspeak && useradd -r -g thingspeak thingspeak
RUN chown -R thingspeak /opt/thingspeak
RUN chgrp -R thingspeak /opt/thingspeak

# process run as thingspeak user
USER thingspeak

EXPOSE 3000
