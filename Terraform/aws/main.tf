terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.aws_region  # Reference the region variable
}

# Define a security group
resource "aws_security_group" "One2N_sg" {
  name        = "One2N-sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Httpserver" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.existing_key_pair_name
  security_groups = [aws_security_group.One2N_sg.name]
  tags = {
    Name = var.instance_name
  }
}
resource "aws_s3_bucket_public_access_block" "http_s3" {
  bucket = aws_s3_bucket.http_s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Define the S3 bucket
resource "aws_s3_bucket" "http_s3" {
  bucket = var.s3_bucket_name
  tags = {
    Name        = "http_s3"
    Environment = "dev"
  }
}
module "s3_uploads" {
  source = "./modules/s3_uploads" # Reference the file where S3 object uploads are defined

    # Pass the S3 bucket name to the module
  bucket_name = aws_s3_bucket.http_s3.bucket
}

resource "time_sleep" "wait" {
  create_duration = "2m" # Wait 1 40s for s3 to stabilize
  depends_on = [var.s3_bucket_name]
}
# Add bucket policy to allow GetObject
resource "aws_s3_bucket_policy" "http_s3_policy" {
  bucket = aws_s3_bucket.http_s3.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "arn:aws:s3:::${aws_s3_bucket.http_s3.id}/*"
      }
    ]
  })
}