#!/bin/sh

TYPE=$1
MASTER="master"
SLAVE="slave"

if [ -z "$TYPE" ]; then
    echo " Failed to config HA, you should run this script with \"master\" or \"slave\" argument."
    exit 1
fi

cd /opt/Sina-HA

echo "#### Configure HA for $TYPE server ..."

echo "#### Making scripts executable ..."
chmod +x ./sh/check/$TYPE/check-alive.sh
if [ $? -ne 0 ]; then
    echo "Failed to make check scripts executable"
fi
chmod +x ./sh/notif/$TYPE/notif.sh
if [ $? -ne 0 ]; then
    echo "Failed to make notify scripts executable"
fi
echo "__________________________________________________________"

echo "#### Copy shell script files ..."
cp ./sh/check/$TYPE/check-alive.sh /usr/local/bin/keepalived_check.sh
if [ $? -ne 0 ]; then
    echo "Failed to copy check script"
fi
cp ./sh/notif/$TYPE/notif.sh /usr/local/bin/keepalived_notify.sh
if [ $? -ne 0 ]; then
    echo "Failed to copy notuft script"
fi
echo "__________________________________________________________"

echo "#### Copy config files ..."
cp ./conf/$TYPE/keepalived.conf /etc/keepalived/keepalived.conf
if [ $? -ne 0 ]; then
    echo "Failed to copy config file"
fi
echo "__________________________________________________________"

echo "#### Checking configs ..."
keepalived -t
echo "__________________________________________________________"

echo "#### Restart Keepalived service ..."
systemctl restart keepalived.service
echo "__________________________________________________________"

echo "#### Check status of Keepalived service ..."
systemctl status keepalived.service
echo "__________________________________________________________"

TIME=$(date)
echo " - [$TIME] : This machine set as $TYPE server. " > /opt/Sina-HA/log/notif.log
