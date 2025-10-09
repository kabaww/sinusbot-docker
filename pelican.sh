#!/bin/bash

apt-get update
apt-get install -y --no-install-recommends \
        git \
        tini \
        ca-certificates \
        bzip2 \
        unzip \
        curl \
        python3 \
        procps \
        libxkbcommon0 \
        locales \
        x11vnc \
        xvfb \
        libxcursor1 \
        libnss3 \
        libegl1-mesa \
        libasound2 \
        libglib2.0-0 \
        libxcomposite-dev \
        less \
        jq \
        libevent-2.1-7 \
        libxcb-xinerama0 \
        liblcms2-2 \
        libatomic1 \
        libxcb-icccm4 \
        libxcb-keysyms1 \
        libxcb-randr0 \
        libxcb-render-util0 \
        libxcb-shape0 \
        libxcb-xkb1 \
        libxkbcommon-x11-0 \
        libpci3 \
        libxslt1.1 \
        libxcb-image0 

git clone https://github.com/kabaww/sinusbot-docker

cd sinusbot-docker
mv install.sh ../install.sh
mv entrypoint.sh ../entrypoint.sh
cd ..

chmod 755 install.sh
chmod 755 entrypoint.sh

./install.sh sinusbot
./install.sh yt-dlp
./install.sh text-to-speech
./install.sh teamspeak

echo "Installation Complete"
./entrypoint.sh

