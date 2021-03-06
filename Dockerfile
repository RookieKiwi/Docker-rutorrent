FROM ubuntu:16.04
USER root

# version labels
ARG VERSION
LABEL build_version="Docker-ruTorrent version ${VERSION} by RookieKiwi"
LABEL maintainer="RookieKiwi"

# copy common files for install
COPY rutorrent-common/ /app/installer-common/

RUN \
    echo "*** Layer 1 - Running container updates and basic installs ***" && \
    DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y git wget unzip unrar

RUN \
    echo "*** Layer 2 - Installing PIP / Python and Cloudscraper ***" && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y libarchive-zip-perl libjson-perl libxml-libxml-perl python3-pip && \
    pip3 install --upgrade pip &&\
    pip3 install cloudscraper

RUN \
    echo "*** Layer 3 - Installing PHP and Web Services ***" && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y curl php-fpm php-cli php-geoip php-mbstring php-zip nginx ffmpeg php-xml

RUN \
    echo "*** Layer 4 - Installing remaining components for ruTorrent and plugins ***" && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y git rtorrent mediainfo supervisor irssi sox && \
    mkdir /app/startup && \
    cp /app/installer-common/rutorrent-*.nginx /app/startup/ && \
    cd /app && \
    git clone https://github.com/Novik/ruTorrent.git rutorrent

RUN \
    echo "*** Layer 5 - Software installed, configuring applications and setting up directories ***" && \
    cd / && \
    cp /app/installer-common/config.php /app/installer-common/startup-rtorrent.sh /app/installer-common/startup-nginx.sh /app/installer-common/startup-php.sh /app/installer-common/startup-irssi.sh /app/installer-common/rtorrent.rc /app/startup/ && \
    cp /app/installer-common/supervisord.conf /etc/supervisor/conf.d/ && \
    chmod +x /app/startup/*.sh && \
    rm -rf /app/installer-common && \
    rm -rf /var/lib/apt/lists/* && \
    sed -i 's/\/var\/log/\/app\/configs\/logs/g' /etc/nginx/nginx.conf

# PORTs web = 31337 / scgi = 31338 / rtorrent = 31339 / ssl = 31340 / dht = 31341

EXPOSE 31337 31338 31339 31340 31341
VOLUME /app/downloads /app/configs

CMD ["supervisord"]