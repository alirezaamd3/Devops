#!/bin/sh

main="192.168.1.105"

if [ -z "`ping -c 3 $main`" ]; then
    exit 1
fi
