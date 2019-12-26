provider "template" {
  version = "~> 2.1"
}

provider "aws" {
  region  = var.aws_region
  version = "~> 2.7"
}

provider "aws" {
  alias   = "us-east-1"
  region  = "us-east-1"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

data "aws_acm_certificate" "us-east-1_ssl_certificate" {
  domain   = var.domain
  provider = aws.us-east-1
}

