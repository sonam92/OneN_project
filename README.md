#### Prerequisite: 
1. Temporary EC2 instance with terraform installation 
2. create IAM user with permission for EC2 and s3 full access
3. copy ***Terraform/aws*** directory on Temporary EC2 instance.
4. replace variable value as per your requirement.

Run below commands to spin infra
#### Terraform command :
- terraform init 
- terraform plan 
- terraform apply -auto-approve


#### Steps to deploy Application.
1. Login to EC2 instance which is created  by terraform code.
2. copy One2N_http_app cd One2N_http_app
3. run deploy.sh
4. This script will install docker, create container and run application in it.
  bash deploy.sh

### description of files:
1) **Dockerfile** - this will will build docker app and create image
2) **http_service.py** -this is application code written in python where flask web application framework used.
3) **deploy.sh** - This will install docker , start service, call Dockerfile and start docker container.
4) **main.tf** - This will create Security group, EC2 instance,s3 bucket , call s3_upload, apply policy to s3 bucket.
5) **s3_uploads.tf** - This will upload files to a directory in s3 bucket
6) **ouput.tf** - This will print output for variables which are present in this file.
7) **variable.tf** - This contain variables which we can change as per our requirnment.
