#!/bin/bash

key_path="/home/ubuntu/spark.pem"
aws_region="us-east-1"
aws_zone="us-east-1c"
nodes="10"
instance_type="m1.large"
aws_vpc="vpc-c1b6faa4"
aws_subnet="subnet-c51fa79c"
master_url="spark://ec2-52-3-89-72.compute-1.amazonaws.com:7077"

# Destroy Spark cluster
yes | /home/ubuntu/PredictionIO/vendors/spark-1.4.1/ec2/spark-ec2 destroy pio

# Launch Spark cluster
/home/ubuntu/PredictionIO/vendors/spark-1.4.1/ec2/spark-ec2 -k spark -i ${key_path} -s ${nodes} --instance-type=${instance_type} --copy-aws-credentials --vpc-id=${aws_vpc} --subnet-id=${aws_subnet} --region=${aws_region} --zone=${aws_zone} --hadoop-major-version=yarn --no-ganglia launch pio

# Stop the cluster
#yes | /home/ubuntu/PredictionIO/vendors/spark-1.4.1/ec2/spark-ec2 stop pio