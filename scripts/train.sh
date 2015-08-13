#!/bin/bash

key_path="/home/ubuntu/spark.pem"

# Go into Scilla folder
cd /home/ubuntu/scilla

# Launch Spark cluster
/home/ubuntu/PredictionIO/vendors/spark-1.4.1/ec2/spark-ec2 -i ${key_path} start pio

# Train the model
/home/ubuntu/PredictionIO/bin/pio train

# Destroy Spark cluster
/home/ubuntu/PredictionIO/vendors/spark-1.4.1/ec2/spark-ec2 stop pio