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

# public demo bucket
resource "aws_s3_bucket" "demo_public_bucket" {
  bucket = "my-demo-public-bucket-003-123456"

  tags = {
    Name        = "Demo Public Bucket"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_public_access_block" "demo_public_access_block" {
  bucket = aws_s3_bucket.demo_public_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "demo_public_policy" {
  bucket = aws_s3_bucket.demo_public_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.demo_public_bucket.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.demo_public_access_block]
}

resource "aws_s3_object" "demo_txt" {
  bucket  = aws_s3_bucket.demo_public_bucket.id
  key     = "demo.txt"
  content = "This is a demo file."
}