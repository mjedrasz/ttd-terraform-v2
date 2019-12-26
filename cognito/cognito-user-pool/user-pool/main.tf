
resource "aws_cognito_user_pool_domain" "domain" {
  domain       = var.domain
  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_user_pool" "pool" {
  name                       = var.name
  username_attributes        = ["email"]
  auto_verified_attributes   = ["email"]

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_subject        = var.verification_email_subject
    email_message        = var.verification_email_message
  }

  email_configuration {
    reply_to_email_address = var.reply_to_email_address
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    # need to specify constraints, otherwise the pool is recreated each time
    # see https://github.com/terraform-providers/terraform-provider-aws/issues/4227
    string_attribute_constraints {
      min_length = 5
      max_length = 40
    }
  }

  password_policy {
    minimum_length    = var.password_minimum_length
    require_lowercase = var.password_require_lowercase
    require_numbers   = var.password_require_numbers
    require_symbols   = var.password_require_symbols
    require_uppercase = var.password_require_uppercase
  }

  admin_create_user_config {
    # workaround for InvalidParameterException: Please use TemporaryPasswordValidityDays in PasswordPolicy instead of UnusedAccountValidityDay
    # see https://github.com/terraform-providers/terraform-provider-aws/issues/8827
    unused_account_validity_days = 0
  }

  lambda_config {
    post_confirmation = var.post_confirmation_lambda_arn
  }

  tags = var.default_tags
}

resource "aws_lambda_permission" "allow_cognito_user_pool" {
  statement_id  = "AllowExecutionFromCognitoUserPool-${var.name}"
  action        = "lambda:InvokeFunction"
  function_name = var.post_confirmation_lambda_arn
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = aws_cognito_user_pool.pool.arn
}

