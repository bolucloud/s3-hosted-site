output "github_s3_hosted_site_user_access_key" {
  value     = aws_iam_access_key.github_s3_hosted_site_user_key.id
  sensitive = true
}

output "github_s3_hosted_site_user_access_secret" {
  value     = aws_iam_access_key.github_s3_hosted_site_user_key.secret
  sensitive = true
}
