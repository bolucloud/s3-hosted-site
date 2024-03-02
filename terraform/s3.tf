resource "aws_s3_bucket" "s3_hosted_site" {
  bucket = var.hosted_site_name

  tags = {
    Name        = var.hosted_site_name
    environment = var.environment
  }
}

resource "aws_s3_bucket_policy" "s3_hosted_site_allow_public_access_policy" {
  bucket = aws_s3_bucket.s3_hosted_site.id
  policy = data.aws_iam_policy_document.s3_hosted_site_allow_public_access_bucket_policy.json
}

resource "aws_s3_bucket_public_access_block" "s3_hosted_site_allow_public_access" {
  bucket = aws_s3_bucket.s3_hosted_site.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

data "aws_iam_policy_document" "s3_hosted_site_allow_public_access_bucket_policy" {
  statement {
    sid       = "PublicReadGetObject"
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::s3-hosted-site.demo.bolu.cloud/*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
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