#!/bin/sh

# Befor anything, run: git clone https://github.com/alirezaamd3/Devops.git --depth 1 --branch=master /opt/devops

echo "Peparing for install ..."
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
apt update

echo "Installing Postgresql..."
apt install -y postgresql

echo "Installing Redis..."
apt install -y redis

echo "Installing .NET ..."
apt install -y apt-transport-https dotnet-sdk-3.1 aspnetcore-runtime-3.1

echo "Installing NPM ..."
apt install -y npm

echo "Installing Python packages ..."
apt install -y python3-redis python3-flask gunicorn

echo "Installing Node modules ..."
cd /opt/devops/voting-system/result-master
npm ci
# npm install -g forever

echo "Installing Nginx ..."
apt install -y nginx

echo "Configuring Postgres ..."
sudo -u postgres createuser -P root
sudo -u postgres createdb voting
cp /opt/devops/Mini-Prj-1/config/postgresql.conf /etc/postgresql/12/main/postgresql.conf
systemctl restart postgresql.service

echo "Configuring Redis ..."
cp /opt/devops/Mini-Prj-1/config/redis.conf /etc/redis/redis.conf
systemctl restart redis-server.service

echo "Configuring Nginx ..."
cp /opt/devops/Mini-Prj-1/config/default /etc/nginx/sites-enabled/default
systemctl restart nginx.service

echo "Check status..."
systemctl status redis.service
systemctl status postgresql.service
systemctl status nginx.service
npm --version
node --version

echo "Building .NET worker app ..."
cd /opt/devops/voting-system/worker-master
dotnet publish -c Release -o ./out Worker.csproj

echo "Installing services ... "
touch /opt/devops/environment
chmod +x /opt/devops/Mini-Prj-1/runner/*.sh
# rm /opt/devops/Mini-Prj-1/service/result.sh
# mkdir /etc/systemd/system/votingapp
# retval=$?
# if [ $retval -ne 0 ]; then
#     systemctl stop vars.service
#     systemctl stop vote.service
#     systemctl stop result.service
#     systemctl stop worker.service
#     rm -r /etc/systemd/system/votingapp
#     systemctl daemon-reload 
#     mkdir /etc/systemd/system/votingapp
# fi
cp /opt/devops/Mini-Prj-1/service/* /etc/systemd/system/
systemctl daemon-reload 
systemctl restart vars.service
systemctl restart vote.service
systemctl restart result.service
systemctl restart worker.service
cd /opt/devops/voting-system/result-master
# forever start server.js

