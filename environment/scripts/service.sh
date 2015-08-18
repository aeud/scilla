#!/bin/sh

case "$1" in
    start)
        bash /home/ubuntu/scilla/environment/scripts/deploy.sh
        ;;
esac

: