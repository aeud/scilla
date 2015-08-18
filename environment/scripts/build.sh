#!/bin/bash

# Set up Scilla
cd /home/ubuntu
rm -rf scilla
git clone git@github.com:project-aprils/scilla.git
cd scilla
/home/ubuntu/PredictionIO/bin/pio build --verbose

# Configure proxy
sudo cp /home/ubuntu/scilla/environment/nginx/scilla /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/scilla /etc/nginx/sites-enabled/scilla
sudo service nginx restart

# Set up Scilla as a service
sudo cp /home/ubuntu/scilla/environment/scripts/service.sh /etc/init.d/scilla
sudo update-rc.d scilla defaults

# Launch Scilla
sudo service scilla deploy