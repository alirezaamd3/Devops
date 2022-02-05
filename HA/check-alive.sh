#!/bin/sh

main="192.168.2.157"

if [ -z "`ping -c 3 $main`" ]; then
    # TYPE=$(cat /root/HA_Test/type)
    # cp ./keepalived-$TYPE-2.cnof /etc/keepalived/keepalived.conf
    # systemctl restart keepalived 
    exit 1
fi

# if [ -z "`wget http://$main:8000`" ]; then
#     exit 1
# fi

