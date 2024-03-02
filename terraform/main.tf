terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39.0"
    }
  }

  backend "s3" {
    bucket         	   = "bolucloud-tfstate"
    key              	   = "state/s3-hosted-site.tfstate"
    region         	   = "us-east-1"
    encrypt        	   = true
    dynamodb_table = "bolucloud_tf_lockid"
  }
}