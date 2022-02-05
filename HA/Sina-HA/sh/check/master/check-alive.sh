#!/bin/sh

main="192.168.2.157"

if [ -z "`ping -c 3 $main`" ]; then
    exit 1
fi

