#!/bin/sh

main="192.168.2.157"
TIME=$(date)

ping -c 3 $main >> /opt/Sina-HA/log/notif.log
echo " - [$TIME] : RETVAL: $? " >> /opt/Sina-HA/log/notif.log

if [ $? -ne 0 ]; then
    
    echo " - [$TIME] : ERROR: Ping to MASTER failed. " >> /opt/Sina-HA/log/notif.log
    # cp /opt/Sina-HA/conf/$TYPE/keepalived-fault.cnof /etc/keepalived/keepalived.conf
    # systemctl restart keepalived 
    exit 1
fi

