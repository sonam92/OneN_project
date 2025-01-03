# Input variable for bucket name
variable "bucket_name" {
  description = "Name of the S3 bucket to upload files to"
  type        = string
}
variable "local_dir" {
  description = "Path to the local directory to upload"
  default     = "./modules/s3_uploads/copyData"
}

# Upload a file to a "directory" in the S3 bucket
resource "aws_s3_object" "upload_files" {
  for_each = fileset(var.local_dir, "**")
  bucket = var.bucket_name
  key    = each.value # Simulating a directory "my_directory"
  source = "${var.local_dir}/${each.value}" # Path to your local file
}

