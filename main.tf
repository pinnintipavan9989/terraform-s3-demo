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

# create demo bucket
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "demo-project-billion-1"

  tags = {
    Name        = "demo-project-billion-1"
    Environment = "dev"
  }
}

# disable public access block restrictions to allow public bucket
resource "aws_s3_bucket_public_access_block" "demo_bucket" {
  bucket = aws_s3_bucket.demo_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# bucket policy to make objects publicly readable
resource "aws_s3_bucket_policy" "demo_bucket" {
  bucket = aws_s3_bucket.demo_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.demo_bucket.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.demo_bucket]
}

# upload a test txt file
resource "aws_s3_bucket_object" "demo_txt" {
  bucket  = aws_s3_bucket.demo_bucket.id
  key     = "demo.txt"
  content = "this is working"
}