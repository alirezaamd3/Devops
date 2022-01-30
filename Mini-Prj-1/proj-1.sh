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
cd /opt/vote-service
wget "https://hamgit.ir/voting-service/vote/-/archive/master/vote-master.tar.gz"
tar -xf vote-master.tar.gz
rm vote-master.tar.gz

echo "getting result app ..."
cd /opt/vote-service
wget "https://hamgit.ir/voting-service/result/-/archive/master/result-master.tar.gz"
tar -xf result-master.tar.gz
rm result-master.tar.gz

echo "getting worker app ..."
cd /opt/vote-service
wget "https://hamgit.ir/voting-service/worker/-/archive/master/worker-master.tar.gz"
tar -xf worker-master.tar.gz
rm worker-master.tar.gz



