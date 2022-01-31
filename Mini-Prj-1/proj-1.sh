#!/bin/sh

echo "Peparing for install ..."
apt update

echo "Installing Postgresql..."
apt install -y postgresql

echo "Installing Redis..."
apt install -y redis

echo "Installing .NET ..."
apt-get install -y apt-transport-https && \
snap install dotnet-sdk --classic

echo "Installing NPM ..."
apt install npm

echo "Installing Nginx ..."
apt install nginx

echo "Check status..."
systemctl status redis.service
systemctl status postgresql.service
systemctl status nginx.service
npm --version
node --version

echo "Creating Directory..."
mkdir /opt/vote-service

echo "getting vote app ..."
git clone https://github.com/alirezaamd3/Devops.git --depth 1 --branch=master /opt/devops


