output "aws_region" {
  value = var.aws_region  # Reference the region variable
}
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.Httpserver.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.Httpserver.public_ip
}
output "s3_bucket_name" {
  value = aws_s3_bucket.http_s3.bucket
}
output "s3_arn" {
value = aws_s3_bucket.http_s3.arn
}
