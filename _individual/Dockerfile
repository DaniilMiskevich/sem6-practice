FROM alpine:3.24
RUN apk update && apk add --no-cache    \
    wireguard-tools nftables            \
    python3

# get code (not master, but a latest [at the moment] release)
RUN wget -O "wgd.tar.gz" "https://github.com/WGDashboard/WGDashboard/archive/refs/tags/v4.3.3.tar.gz"   &&\
    tar -xf ./wgd.tar.gz && rm ./wgd.tar.gz                                                             &&\
    mv "./WGDashboard-4.3.3" ./wgd
WORKDIR /wgd/src
COPY main.sh ./main.sh

# a couple of small patches
RUN echo "daemon = False" >> ./gunicorn.conf.py && echo "chdir = '/wgd/run'" >> ./gunicorn.conf.py
RUN cat <( echo '#!/bin/bash' && echo 'sudo() { $@; }' ) ./wgd.sh > /tmp/wgd.sh && mv /tmp/wgd.sh ./wgd.sh && chmod +x ./wgd.sh

# install app depends
RUN ./wgd.sh install

# copy config template (with safe rights)
COPY default.conf /tmp/default.conf
RUN chmod 600 /tmp/default.conf

CMD ["sh", "./main.sh"]
