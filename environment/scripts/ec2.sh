#!/bin/bash

sudo apt-get update && yes | sudo apt-get upgrade

cd

sudo apt-get install build-essentials git nginx

bash -c "$(curl -s https://install.prediction.io/install.sh)"

sudo cp /home/ubuntu/scilla/environment/nginx/scilla /etc/nginx/sites-available
sudo ln -s /etc/nginx/sites-available/scilla /etc/nginx/sites-enabled/scilla

sudo service nginx restart

cd /home/ubuntu/scilla
pio deploy --port 8001 -- --driver-memory 4g