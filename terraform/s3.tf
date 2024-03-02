resource "aws_s3_bucket" "s3_hosted_site" {
  bucket = var.hosted_site_name

  tags = {
    Name        = var.hosted_site_name
    environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "s3_hosted_site_public_access_block" {
  bucket                  = aws_s3_bucket.s3_hosted_site.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_website_configuration" "s3_hosted_site_config" {
  bucket = aws_s3_bucket.s3_hosted_site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}