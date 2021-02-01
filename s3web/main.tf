provider "template" {
}

provider "aws" {
  region  = var.aws_region

}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

resource "aws_s3_bucket" "bucket" {
  region             = var.aws_region
  bucket             = "${var.aws_env}-${var.bucket_name}"
  acl                = "private" # https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl

  website {
    index_document = "index.html"
    error_document = ""
  }

  cors_rule {
    allowed_headers = var.cors_allowed_headers
    allowed_methods = var.cors_allowed_methods
    allowed_origins = var.cors_allowed_origins
    expose_headers  = var.cors_expose_headers 
    max_age_seconds = var.cors_max_age_seconds
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy =<<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "cloudfront",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.origin_access_identity.id}"
            },
            "Action": "s3:GetObject",
            "Resource": "${aws_s3_bucket.bucket.arn}/*"
        }
    ]
}
POLICY
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "${var.aws_env}-OAI-${var.bucket_name}"
}

resource "aws_ssm_parameter" "s3" {
  count = var.ssm_bucket_name == "" ? 0 : 1
  name  = "/${var.aws_env}/s3/${var.ssm_bucket_name}"
  type  = "String"
  value = aws_s3_bucket.bucket.bucket
}