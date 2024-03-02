resource "aws_acm_certificate" "s3_hosted_site_cert" {
  domain_name       = "projects.bolu.cloud"
  validation_method = "DNS"

  subject_alternative_names = [
    "*.projects.bolu.cloud"
  ]

  lifecycle {
    create_before_destroy = true
  }
}