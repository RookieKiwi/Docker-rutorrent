FROM ubuntu:16.04
USER root

# version labels
ARG VERSION
LABEL build_version="Docker-ruTorrent version ${VERSION} by RookieKiwi"
LABEL maintainer="RookieKiwi"

# copy common files for install
COPY rutorrent-common/ /app/installer-common/

RUN \
    echo "*** updating ubuntu apt sources ***" && \
    apt-get update && \
    echo "*** installing runtime applications ***" && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y git rtorrent unzip unrar mediainfo curl php-fpm php-cli php-geoip php-mbstring php-zip nginx wget ffmpeg supervisor php-xml libarchive-zip-perl libjson-perl libxml-libxml-perl irssi sox python3-pip && \
    pip3 install cloudscraper && \ 
    cp /app/installer-common/rutorrent-*.nginx /root/ && \
    cd /app && \
    echo "*** installing and configuring rutorrent ***" && \
    git clone https://github.com/Novik/ruTorrent.git rutorrent && \
    cd / && \
    cp /app/installer-common/config.php /app/rutorrent/conf/ && \
    cp /app/installer-common/startup-rtorrent.sh /app/installer-common/startup-nginx.sh /app/installer-common/startup-php.sh /app/installer-common/startup-irssi.sh /app/installer-common/rtorrent.rc /root/ && \
    mv /root/rtorrent.rc /root/.rtorrent.rc && \
    cp /app/installer-common/supervisord.conf /etc/supervisor/conf.d/ && \
    echo "*** cleaning up mess, should be all done! ***" && \
    rm -rf /rutorrent/.git* && \
    rm -rf /app/installer-common && \
    rm -rf /var/lib/apt/lists/* && \
    sed -i 's/\/var\/log/\/downloads\/\.log/g' /etc/nginx/nginx.conf

EXPOSE 80 443 49160 49161 5000
VOLUME /downloads /config

CMD ["supervisord"]