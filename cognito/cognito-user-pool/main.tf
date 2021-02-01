provider "template" {
}

provider "aws" {
  region  = var.aws_region

}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

resource "aws_ssm_parameter" "user_pool_id" {
  name  = "/${var.aws_env}/cognito/user-pools/user/id"
  type  = "String"
  value = module.user-pool.cognito_user_pool_id
}

resource "aws_ssm_parameter" "org_pool_id" {
  name  = "/${var.aws_env}/cognito/user-pools/org/id"
  type  = "String"
  value = module.org-pool.cognito_user_pool_id
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}