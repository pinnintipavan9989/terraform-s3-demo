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

# demo-terrapilot-ai-2 bucket
resource "aws_s3_bucket" "demo_2" {
  bucket = "demo-terrapilot-ai-2"

  tags = {
    Name = "demo-terrapilot-ai-2"
  }
}

resource "aws_s3_bucket_public_access_block" "demo_2" {
  bucket = aws_s3_bucket.demo_2.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "demo_2" {
  bucket = aws_s3_bucket.demo_2.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.demo_2.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.demo_2]
}

# demo-terrapilot-ai-3 bucket
resource "aws_s3_bucket" "demo_3" {
  bucket = "demo-terrapilot-ai-3"

  tags = {
    Name = "demo-terrapilot-ai-3"
  }
}

resource "aws_s3_bucket_public_access_block" "demo_3" {
  bucket = aws_s3_bucket.demo_3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "demo_3" {
  bucket = aws_s3_bucket.demo_3.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.demo_3.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.demo_3]
}

# text file in demo-terrapilot-ai-3 bucket
resource "aws_s3_object" "demo_3_txt" {
  bucket       = aws_s3_bucket.demo_3.id
  key          = "test.txt"
  content      = "This is working"
  content_type = "text/plain"
}

output "demo_2_bucket_name" {
  value = aws_s3_bucket.demo_2.bucket
}

output "demo_3_bucket_name" {
  value = aws_s3_bucket.demo_3.bucket
}