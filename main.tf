# create first S3 bucket
resource "aws_s3_bucket" "bucket1" {
  bucket = "my-demo-bucket-001-123456"

  tags = {
    Name = "Demo Bucket 1"
  }
}

# create second S3 bucket
resource "aws_s3_bucket" "bucket2" {
  bucket = "my-demo-bucket-002-123456"

  tags = {
    Name = "Demo Bucket 2"
  }
}

# create third S3 bucket for demo project
resource "aws_s3_bucket" "demo_project_billion_1" {
  bucket = "demo-project-billion-1"

  tags = {
    Name        = "Demo Project Billion 1"
    Environment = "dev"
  }
}