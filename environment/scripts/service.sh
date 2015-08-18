#!/bin/sh

case "$1" in
    start)
        bash /home/ubuntu/scilla/environment/scripts/build.sh >> /home/ubuntu/log/pio.log &>> /home/ubuntu/log/pio-err.log
        ;;
    deploy)
        bash /home/ubuntu/scilla/environment/scripts/deploy.sh >> /home/ubuntu/log/pio.log &>> /home/ubuntu/log/pio-err.log
        ;;
esac

: