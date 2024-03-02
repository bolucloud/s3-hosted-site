resource "aws_acm_certificate" "s3_hosted_site_cert" {
  domain_name       = "demo.bolu.cloud"
  validation_method = "DNS"

  subject_alternative_names = [
    "*.demo.bolu.cloud"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "demo_bolu_cloud_cert_validation" {
  certificate_arn         = aws_acm_certificate.s3_hosted_site_cert.arn
  validation_record_fqdns = [aws_route53_record.demo_bolu_cloud_acm_dns.fqdn]
}