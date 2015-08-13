 #!/bin/bash

# Go into Scilla folder
cd /home/ubuntu/scilla

# Launch Spark cluster
/home/ubuntu/PredictionIO/vendors/spark-1.4.1/ec2/spark-ec2 start pio

# Train the model
/home/ubuntu/PredictionIO/bin/pio train

# Destroy Spark cluster
/home/ubuntu/PredictionIO/vendors/spark-1.4.1/ec2/spark-ec2 stop pio