
module "user-pool" {
  source                       = "./user-pool"
  domain                       = "${var.aws_env}-${var.user_pool_domain}"
  name                         = "${var.aws_env}-${var.user_pool_name}"
  password_minimum_length      = var.password_minimum_length
  password_require_lowercase   = var.password_require_lowercase
  password_require_numbers     = var.password_require_numbers
  password_require_symbols     = var.password_require_symbols
  password_require_uppercase   = var.password_require_uppercase
  reply_to_email_address       = var.reply_to_email_address
  default_tags                 = var.default_tags
  verification_email_message   = var.user_verification_email_message
  verification_email_subject   = var.user_verification_email_subject
  post_confirmation_lambda_arn = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${var.aws_env}-lambda-init-profile"
}

