resource "aws_cloudfront_distribution" "s3_hosted_site_cloudfront_distro" {
  origin {
    domain_name         = "www.bolucloudtestbucket.demo.bolu.cloud.s3-website-us-east-1.amazonaws.com"
    origin_id           = "www.bolucloudtestbucket.demo.bolu.cloud.s3.us-east-1.amazonaws.com"
    connection_attempts = 3
    connection_timeout  = 10
    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols = [
        "SSLv3",
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2"
      ]
    }
  }
  aliases = [
    "bolucloudtestbucket.demo.bolu.cloud"
  ]
  enabled         = true
  is_ipv6_enabled = true
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.s3_hosted_site_cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  default_cache_behavior {
    viewer_protocol_policy = "allow-all"
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # Using the CachingDisabled managed policy ID:
    allowed_methods        = ["GET", "HEAD"]
    compress               = true
    target_origin_id       = "www.bolucloudtestbucket.demo.bolu.cloud.s3.us-east-1.amazonaws.com"
  }
  depends_on = [
    aws_acm_certificate.s3_hosted_site_cert,
    aws_s3_bucket.s3_hosted_site
  ]
}