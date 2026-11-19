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

# create third S3 bucket (demo-automation-2) - kept private per guardrails
resource "aws_s3_bucket" "demo_automation_2" {
  bucket = "demo-automation-2"

  tags = {
    Name        = "Demo Automation Bucket"
    Environment = "dev"
  }
}

# upload a text file to the demo-automation-2 bucket
resource "aws_s3_object" "demo_txt" {
  bucket  = aws_s3_bucket.demo_automation_2.id
  key     = "example.txt"
  content = "This is a sample text file for the dev environment."

  # No ACL is set; the bucket remains private in compliance with security guardrails.
}