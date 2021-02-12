resource "aws_cognito_user_pool_domain" "domain" {
  domain       = "${var.aws_env}-${var.domain}"
  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_user_pool" "pool" {
  name                       = "${var.aws_env}-${var.name}"
  username_attributes        = ["email"]
  auto_verified_attributes   = ["email"]

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = var.verification_email_subject
    email_message        = var.verification_email_message
  }

  # email_configuration {
  #   reply_to_email_address = var.reply_to_email_address
  # }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      min_length = 5
      max_length = 40
    }
  }

  password_policy {
    minimum_length                   = var.password_minimum_length
    require_lowercase                = var.password_require_lowercase
    require_numbers                  = var.password_require_numbers
    require_symbols                  = var.password_require_symbols
    require_uppercase                = var.password_require_uppercase
    temporary_password_validity_days = 7
  }

  lambda_config {
    post_confirmation = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${var.aws_env}-lambda-init-profile"
  }

  tags = var.default_tags
}

resource "aws_ssm_parameter" "pool_id" {
  name  = "/${var.aws_env}/cognito/user-pools/${var.name}/id"
  type  = "String"
  value = aws_cognito_user_pool.pool.id
}

resource "aws_ssm_parameter" "pool_arn" {
  name  = "/${var.aws_env}/cognito/user-pools/${var.name}/arn"
  type  = "String"
  value = aws_cognito_user_pool.pool.arn
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
