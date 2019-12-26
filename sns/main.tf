provider "template" {
  version = "~> 2.1"
}

provider "aws" {
  region  = var.aws_region
  version = "~> 2.7"
}


terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

resource "aws_sns_topic" "fanout" {
  name = "${var.aws_env}-fanout"
}

resource "aws_ssm_parameter" "fanout_arn" {
  name  = "/${var.aws_env}/sns/topics/fanout/arn"
  type  = "String"
  value = aws_sns_topic.fanout.arn
}
