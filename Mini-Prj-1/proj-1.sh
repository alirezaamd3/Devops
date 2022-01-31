#!/bin/sh

# Befor anything, run: git clone https://github.com/alirezaamd3/Devops.git --depth 1 --branch=master /opt/devops

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
apt install -y npm

echo "Installing Python packages ..."
apt install -y python3-pip
pip3 install redis flask gunicron

echo "Installing Node modules ..."
cd /opt/devops/voting-system/result-master
npm ci

echo "Installing Nginx ..."
apt install -y nginx

echo "Configuring Postgres ..."
su - postgres
createuser -P root
createdb voting
exit
cp /opt/devops/Mini-Prj-1/config/postgresql.conf /etc/postgresql/12/main/postgresql.conf
systemctl restart postgres.service

echo "Configuring Redis ..."
cp /opt/devops/Mini-Prj-1/config/redis.conf /etc/redis/redis.conf
systemctl restart postgres.service

echo "Configuring Nginx ..."
cp /opt/devops/Mini-Prj-1/config/default /etc/nginx/sites-enabled/
systemctl restart nginx.service

echo "Check status..."
systemctl status redis.service
systemctl status postgresql.service
systemctl status nginx.service
npm --version
node --version

echo "Creating Directory..."
mkdir /opt/vote-service

echo "Building .NET worker app ..."
cd /opt/devops/voting-system/worker-master
dotnet publish -c Release -o ./out /out Worker.csproj

echo "Installing services ... "
cp /opt/devops/Mini-Prj-1/service/* /etc/systemd/system/
systemctl daemon-reload 
systemctl status vote.service
systemctl status result.service
systemctl status worker.service
