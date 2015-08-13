 #!/bin/bash

# Go into Scilla folder
cd /home/ubuntu/scilla

# Launch Spark cluster
/home/ubuntu/PredictionIO/vendors/spark-1.4.1/ec2/spark-ec2 -k spark -i /home/ubuntu/spark.pem -s 1 --instance-type=m1.large --copy-aws-credentials --vpc-id=vpc-c1b6faa4 --subnet-id=subnet-c51fa79c --region=us-east-1 --zone=us-east-1c --hadoop-major-version=yarn launch pio

# Train the model
/home/ubuntu/PredictionIO/bin/pio train

# Destroy Spark cluster
/home/ubuntu/PredictionIO/vendors/spark-1.4.1/ec2/spark-ec2 destroy pio