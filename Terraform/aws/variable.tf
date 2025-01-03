# Variable to specify the AWS region
variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "ap-south-1"  # Change this default to your preferred region
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "HttpServer"

}
variable "ami_id" {
  default = "ami-0fd05997b4dff7aac" # Example Amazon Linux AMI
}

variable "instance_type" {
  default = "t2.micro"
}

# Use an existing key pair by referencing its name
variable "existing_key_pair_name" {
  description = "Name of the existing key pair"
  default     = "One2N" # Replace with your key pair name
}
variable "s3_bucket_name" {
  description = "Name of the S3 bucket (must be globally unique)"
  default     = "http-s3-bucket"
}
