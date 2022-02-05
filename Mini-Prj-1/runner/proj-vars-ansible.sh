#!/bin/sh

REDIS_IP="$1"
REDIS_PORT=$2
REDIS_PASS="$3"
PG_DB="$4"
PG_IP="$5"
PG_PORT=$6
PG_USER="$7"
PG_PASS="$8"

# cat /etc/environment | grep REDIS_IP
# retval =$?

# if [ $retval -ne 0 ]; then
echo "REDIS_IP=\"$REDIS_IP\"" > /opt/devops/environment
echo "REDIS_PORT=$REDIS_PORT" >> /opt/devops/environment
echo "REDIS_PASS=\"$REDIS_PASS\"" >> /opt/devops/environment
echo "REDIS_HOST_DN=\"$REDIS_IP:$REDIS_PORT,password=$REDIS_PASS\"" >> /opt/devops/environment
echo "PG_HOST_DN=\"Server=$PG_IP;Port=$PG_PORT;User Id=$PG_USER;Password=$PG_PASS;Database=$PG_DB;\"" >> /opt/devops/environment
echo "PG_HOST_JS=\"postgres://$PG_USER:$PG_PASS@$PG_IP:$PG_PORT/$PG_DB\"" >> /opt/devops/environment
# fi
