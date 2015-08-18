#!/bin/sh

cd /home/ubuntu/scilla
/home/ubuntu/PredictionIO/bin/pio deploy --port 8001 --engine-id 709vsYeLDjbQ13lAB718UdpxlHvD6jrG --engine-version a45f3aacfb7e261f4f7707e8641f1aae6c000651 -- --driver-memory 6g >> /home/ubuntu/log/pio.log &>> /home/ubuntu/log/pio-err.log 