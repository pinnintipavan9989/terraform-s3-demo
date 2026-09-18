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

# create the required demo bucket in us-east-1
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "demo-mission-12-us-east-1"

  tags = {
    Name = "Demo Mission Bucket"
  }
}

# upload a demo.txt file into the demo bucket
resource "aws_s3_object" "demo_txt" {
  bucket = aws_s3_bucket.demo_bucket.id
  key    = "demo.txt"

  content = "Demo file content"

  # No ACL is set; defaults to bucket-owner enforced ownership
}