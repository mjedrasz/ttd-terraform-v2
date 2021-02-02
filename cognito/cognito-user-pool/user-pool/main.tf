
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
  }

  password_policy {
    minimum_length    = var.password_minimum_length
    require_lowercase = var.password_require_lowercase
    require_numbers   = var.password_require_numbers
    require_symbols   = var.password_require_symbols
    require_uppercase = var.password_require_uppercase
  }

  lambda_config {
    post_confirmation = var.post_confirmation_lambda_arn
  }

  tags = var.default_tags
}


