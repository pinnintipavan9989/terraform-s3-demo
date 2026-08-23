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

# demo-project-billion-1 bucket
resource "aws_s3_bucket" "demo_project_billion_1" {
  bucket = "demo-project-billion-1"

  tags = {
    Name        = "demo-project-billion-1"
    Environment = "dev"
  }
}

# disable public access block settings to allow public bucket
resource "aws_s3_bucket_public_access_block" "demo_project_billion_1" {
  bucket = aws_s3_bucket.demo_project_billion_1.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# bucket policy to make objects publicly readable
resource "aws_s3_bucket_policy" "demo_project_billion_1" {
  bucket = aws_s3_bucket.demo_project_billion_1.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.demo_project_billion_1.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.demo_project_billion_1]
}

# upload a txt file indicating the bucket is working
resource "aws_s3_object" "demo_txt" {
  bucket  = aws_s3_bucket.demo_project_billion_1.id
  key     = "demo.txt"
  content = "this is working"
}