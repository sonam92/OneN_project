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
