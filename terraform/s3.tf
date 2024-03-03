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


data "aws_iam_policy_document" "s3_hosted_site_allow_public_access_bucket_policy" {
  statement {
    sid = "PublicReadGetObject"
    actions = [
      "s3:GetObject",
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::www.bolucloudtestbucket.demo.bolu.cloud/*",
      "arn:aws:s3:::www.bolucloudtestbucket.demo.bolu.cloud"
    ]
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