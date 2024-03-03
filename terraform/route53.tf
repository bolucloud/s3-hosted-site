data "aws_route53_zone" "demo_bolucloud_zone" {
  name         = "demo.bolu.cloud"
  private_zone = false
}

resource "aws_route53_record" "s3_cloudfront_distribution_cname" {
  zone_id    = data.aws_route53_zone.demo_bolucloud_zone.zone_id
  name       = var.hosted_site_name
  type       = "CNAME"
  ttl        = "60"
  records    = [aws_cloudfront_distribution.s3_hosted_site_cloudfront_distro.domain_name]
  depends_on = [aws_cloudfront_distribution.s3_hosted_site_cloudfront_distro]
}

resource "aws_route53_record" "s3_cloudfront_distribution_alias" {
  zone_id = data.aws_route53_zone.demo_bolucloud_zone.zone_id
  name    = "bolucloudtestbucket.demo.bolu.cloud"
  type    = "A"
  alias {
    evaluate_target_health = false
    name                   = "dvlqyf7rz6dw1.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
  }
  depends_on = [aws_cloudfront_distribution.s3_hosted_site_cloudfront_distro]
}

# this section adds the route53 record needed to validate the certificate 
resource "aws_route53_record" "demo_bolu_cloud_acm_dns" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.s3_hosted_site_cert.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.s3_hosted_site_cert.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.s3_hosted_site_cert.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.demo_bolucloud_zone.zone_id
  ttl             = 60
}

