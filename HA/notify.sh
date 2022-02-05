#!/bin/sh

# TYPE=$(cat /root/HA_Test/type)
echo "NOTIFY $1 $2 $3" > /root/HA_Test/error

cd 
cp ./keepalived-slave-2.cnof /etc/keepalived/keepalived.conf
systemctl restart keepalived.service