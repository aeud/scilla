#!/bin/bash

sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install build-essential git nginx

# Set up PIO
bash -c "$(curl -s https://install.prediction.io/install.sh)"

# Set up Scilla
cd /home/ubuntu
git clone git@github.com:project-aprils/scilla.git
cd scilla
/home/ubuntu/PredictionIO/bin/pio build --verbose

# Configure proxy
sudo cp /home/ubuntu/scilla/environment/nginx/scilla /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/scilla /etc/nginx/sites-enabled/scilla
sudo service nginx restart

# Set up Scilla as a service
sudo cp /home/ubuntu/scilla/environment/scripts/service.sh /etc/init.d/scilla

# Launch Scilla
sudo service scilla start