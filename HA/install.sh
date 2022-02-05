#!/bin/sh

TYPE=$1
Master="master"
Slave="slave"

echo "$TYPE Node Installation"
touch /root/HA_Test/environment
echo "$TYPE" > /root/HA_Test/type

echo "Installing testing requirements ..."
# apt update
apt install -y python3-pip
pip3 install fastapi uvicorn[standard]

echo "Installing HA applicaiton ..."
apt install -y keepalived

echo "Running test http service ..."
echo $1 > /root/HA_Test/environment
chmod +x /root/HA_Test/FastAPI/run.sh
cp ./hatest.service /etc/systemd/system/
systemctl daemon-reload

echo "Coppiny files ..."
chmod +x ./*.sh
cp ./check-alive.sh /usr/local/bin/keepalived_check.sh
cp ./notify.sh /usr/local/bin/keepalived_notify.sh
cp ./keepalived-$TYPE.conf /etc/keepalived/keepalived.conf

echo "Restarting keepalived service ..."
systemctl restart keepalived.service
