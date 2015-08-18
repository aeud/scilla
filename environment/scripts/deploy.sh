#!/bin/sh

cd /home/ubuntu/scilla
sudo /home/ubuntu/PredictionIO/bin/pio deploy --port 8001 -- --driver-memory 6g >> /var/log/pio.log &>> pio-err.log 