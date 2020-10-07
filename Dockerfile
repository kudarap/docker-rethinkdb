FROM ubuntu:bionic

RUN apt-get -qqy update \
    && apt-get install -y --no-install-recommends ca-certificates gnupg2 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys "539A 3A8C 6692 E6E3 F69B 3FE8 1D85 E93F 801B B43F" \
    && echo "deb https://download.rethinkdb.com/apt bionic main" > /etc/apt/sources.list.d/rethinkdb.list

ENV RETHINKDB_PACKAGE_VERSION 2.4.1~0bionic

RUN apt-get -qqy update \
        && apt-get install -y rethinkdb=$RETHINKDB_PACKAGE_VERSION python-pip \
        && rm -rf /var/lib/apt/lists/*

RUN pip install rethinkdb

VOLUME ["/data"]

WORKDIR /data

CMD ["rethinkdb", "--bind", "all"]

#   process cluster webui
EXPOSE 28015 29015 8080
