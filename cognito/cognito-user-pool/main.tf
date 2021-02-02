provider "template" {
}

provider "aws" {
  region  = var.aws_region

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

resource "aws_ssm_parameter" "user_pool_arn" {
  name  = "/${var.aws_env}/cognito/user-pools/user/arn"
  type  = "String"
  value = module.user-pool.cognito_user_pool_arn
}

resource "aws_ssm_parameter" "org_pool_arn" {
  name  = "/${var.aws_env}/cognito/user-pools/org/arn"
  type  = "String"
  value = module.org-pool.cognito_user_pool_arn
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}