#!/bin/bash

# Set up Scilla
cd /home/ubuntu/scilla
git pull
/home/ubuntu/PredictionIO/bin/pio build --verbose

# Configure proxy
sudo cp /home/ubuntu/scilla/environment/nginx/scilla /etc/nginx/sites-available/
sudo rm /etc/nginx/sites-enabled/scilla
sudo ln -s /etc/nginx/sites-available/scilla /etc/nginx/sites-enabled/scilla
sudo service nginx restart

# Set up Scilla as a service
# sudo cp /home/ubuntu/scilla/environment/scripts/service.sh /etc/init.d/scilla
# sudo update-rc.d -f scilla remove
# sudo update-rc.d scilla defaults

# Launch Scilla
sudo service scilla deploy