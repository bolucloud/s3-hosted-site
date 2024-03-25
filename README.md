# Static Website Hosting on S3 via Cloudfront


## Overview
This infrastructure is built to deploy the necessary AWS services needed to host a secure static website using a S3 bucket, ACM Certificate Manager, Cloudfront and Route53.


## Features
- CDN: uses cloudfront as a CDN for lowest latency experience for end users.
- CI/CD: automated deployment of updated frontend code.
- Custom domain: utilizes customized FQDN.
- Security: site is secured with a SSL certificate.


## Prerequisites
- AWS Account
- Terraform
- Cloudformation
- Github / Github Actions

## Architecture

![s3-hosted-site bolucloud architecture diagram](./s3-hosted-site.drawio.svg)

## Blog
Detailed writeup for this project can be found on my blog: 
Part 1 👉🏿 https://bolu.cloud/2024/03/03/static-website-hosting-on-aws-s3-via-cloudfront/
Part 2 👉🏿 https://bolu.cloud/2024/03/24/part-2-static-website-hosting-on-aws-s3-github-actions-ci-cd/