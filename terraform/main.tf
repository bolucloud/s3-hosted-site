terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "bolucloud"

    workspaces {
      name = "s3-hosted-site"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.9.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}