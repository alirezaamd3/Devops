#!/bin/sh

cd /d/Learning/FastAPI

echo "server $1" > num.txt
echo "Running server $1"
uvicorn main:app --reload --host 0.0.0.0 --port $2 
sleep 5s

