#!/bin/sh

echo "Running voting app with gunicorn ..."
cd /opt/devops/voting-system/vote-master/
gunicorn app:app -b 0.0.0.0:8080 --log-file - --access-logfile - --workers 4 --keep-alive 0