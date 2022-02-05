#!/bin/sh

cd /root/HA_Test/FastAPI
TYPE=$1

if [ -z "$1" ]; then
    TYPE=$(cat /root/HA_Test/type)
else
    TYPE=$1
fi

echo "server $TYPE" > num.txt
echo "Running server $TYPE"
uvicorn main:app --reload --host 0.0.0.0 --port 8000
sleep 5s

