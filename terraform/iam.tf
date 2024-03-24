resource "aws_iam_user" "github_s3_hosted_site_user" {
  name = "github-s3-hosted-site-user"
}

resource "aws_iam_access_key" "github_s3_hosted_site_user_key" {
  user = aws_iam_user.github_s3_hosted_site_user.name
}

data "aws_iam_policy_document" "github_s3_hosted_site_user_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListAllBuckets"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::www.bolucloudtestbucket.demo.bolu.cloud/*",
      "arn:aws:s3:::www.bolucloudtestbucket.demo.bolu.cloud"
    ]
  }
}

resource "aws_iam_user_policy" "github_s3_hosted_site_user_policy" {
  name   = "github-s3-hosted-site-user-policy"
  user   = aws_iam_user.github_s3_hosted_site_user.name
  policy = data.aws_iam_policy_document.github_s3_hosted_site_user_policy_document.json
}
