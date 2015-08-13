#!/bin/bash

key_path="/home/ubuntu/spark.pem"
master_url="spark://ec2-52-3-89-72.compute-1.amazonaws.com:7077"

# Go into Scilla folder
cd /home/ubuntu/scilla

# Launch Spark cluster
/home/ubuntu/PredictionIO/vendors/spark-1.4.1/ec2/spark-ec2 -i ${key_path} start pio

# Train the model
/home/ubuntu/PredictionIO/bin/pio train -- --master ${master_url}

# Destroy Spark cluster
/home/ubuntu/PredictionIO/vendors/spark-1.4.1/ec2/spark-ec2 stop pio