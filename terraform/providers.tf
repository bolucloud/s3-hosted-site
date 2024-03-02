provider "aws" {
  profile = "default"
  region  = "us-east-1"
  default_tags {
    tags = {
      project     = "s3-hosted-site"
      github      = "https://github.com/bolucloud/s3-hosted-site"
      environment = var.environment
      managed_by  = "terraform"
    }
  }
}