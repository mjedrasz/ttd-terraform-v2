provider "template" {
}

provider "aws" {
  region  = var.aws_region

}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

resource "aws_ssm_parameter" "lambda_contact_us_recipients" {
  name  = "/${var.aws_env}/lambda/contact-us/recipients"
  type  = "String"
  value = var.lambda_contact_us_recipients
  tags  = var.default_tags
}
