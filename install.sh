#!/usr/bin/env bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit 1
fi

apt-get update

if [ ! $(which wget) ]; then
    apt-get install wget
fi

if [ ! $(which git) ]; then
    apt-get install git
fi

if [ ! $(which unzip) ]; then
    apt-get install unzip
fi

if [ ! -e localtonet.service ]; then
    git clone --depth=1 https://github.com/engineseller/localtonet.git
    cd localtonet
fi

cp localtonet.service /lib/systemd/system/
mkdir -p /opt/localtonet

cd /opt/localtonet

wget https://localtonet.com/download/linux-x64.zip
# wget https://localtonet.com/download/linux-arm.zip

unzip linux-x64.zip
rm linux-x64.zip
chmod +x localtonet

systemctl enable localtonet.service
systemctl start localtonet.service
