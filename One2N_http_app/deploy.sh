#!/bin/bash
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo chkconfig docker on
sudo usermod -aG docker ec2-user
read -p "Enter AWS Access Key ID: " AWS_ACCESS_KEY_ID
read -sp "Enter AWS Secret Access Key: " AWS_SECRET_ACCESS_KEY
echo -e "\n"
sudo docker build -t python-flask-boto3-app .
#please provide keys in command line
sudo docker run -d -p 5000:5000 -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY python-flask-boto3-app
