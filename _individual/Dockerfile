FROM alpine:3.24
RUN apk update && apk add --no-cache    \
    wireguard-tools iptables            \
    python3

# get code (not master, but a latest [at the moment] release)
RUN wget -O "wgd.tar.gz" "https://github.com/WGDashboard/WGDashboard/archive/refs/tags/v4.3.3.tar.gz"   &&\
    tar -xf ./wgd.tar.gz && rm ./wgd.tar.gz                                                             &&\
    mv "./WGDashboard-4.3.3" ./wgd
WORKDIR /wgd/src

# a couple of small patches
RUN echo "daemon = False" >> ./gunicorn.conf.py
RUN cat <(echo '#!/bin/bash' && echo 'sudo() { $@; }') ./wgd.sh > /tmp/wgd.sh && mv /tmp/wgd.sh ./wgd.sh && chmod +x ./wgd.sh

# install app depends
RUN ./wgd.sh install

WORKDIR /wgd/src
CMD ["./wgd.sh", "start"]
