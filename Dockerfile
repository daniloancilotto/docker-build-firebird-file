FROM debian
MAINTAINER Danilo Ancilotto

ENV DEBIAN_FRONTEND noninteractive
ENV DOWNLOAD_URL=https://sourceforge.net/projects/firebird/files/firebird-linux-amd64/2.1.7-Release/FirebirdSS-2.1.7.18553-0.amd64.tar.gz

RUN apt update && \
    apt upgrade -qy && \
    apt install -qy \
        libstdc++5 \
        curl \
        alien && \
    mkdir -p /home/firebird && \
    cd /home/firebird && \
    curl -o firebird.rpm \
        -L "https://sourceforge.net/projects/firebird/files/firebird-linux-amd64/2.1.7-Release/FirebirdSS-2.1.7.18553-0.amd64.rpm" && \
    alien -c firebird.rpm && \
    dpkg -i *.deb && \
    cd / && \
    rm -rf /home/firebird && \
    apt purge -qy --auto-remove \
        alien \
        curl && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3050/tcp

ENTRYPOINT /opt/firebird/bin/fbguard
