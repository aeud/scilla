#!/bin/bash

key_path="/home/ubuntu/spark.pem"
master_url="spark://ec2-52-3-89-72.compute-1.amazonaws.com:7077"
driver_memory="20"
executor_memory="27"

# Go into working folder
cd /home/ubuntu/scilla

# Launch Spark cluster
/home/ubuntu/PredictionIO/vendors/spark-1.4.1/ec2/spark-ec2 -i ${key_path} start pio

# Train the model
/home/ubuntu/PredictionIO/bin/pio train -- --master ${master_url} --executor-memory ${executor_memory}g --driver-memory ${driver_memory}g

# Destroy Spark cluster
yes | /home/ubuntu/PredictionIO/vendors/spark-1.4.1/ec2/spark-ec2 stop pio

# /home/ubuntu/PredictionIO/bin/pio train -- --master spark://ec2-52-3-89-72.compute-1.amazonaws.com:7077 --executor-memory 13g --driver-memory 20g