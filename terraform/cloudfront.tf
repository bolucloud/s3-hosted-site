resource "aws_cloudfront_distribution" "s3_hosted_site_cloudfront_distro" {
  origin {
    domain_name = aws_s3_bucket.s3_hosted_site.bucket_regional_domain_name
    origin_id   = "${var.hosted_site_name}"
  }
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "s3 demo site cloudfront"
  default_root_object = "index.html"
  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.s3_hosted_site_cert.arn
    ssl_support_method = "sni-only"
  }
  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad" # Using the CachingDisabled managed policy ID:
    allowed_methods        = ["GET", "HEAD"]
    target_origin_id       = "${var.hosted_site_name}"
  }
  depends_on = [
    aws_acm_certificate.s3_hosted_site_cert,
    aws_s3_bucket.s3_hosted_site
  ]
}