
module "org-pool" {
  source                       = "./user-pool"
  domain                       = "${var.aws_env}-${var.org_pool_domain}"
  name                         = "${var.aws_env}-${var.org_pool_name}"
  password_minimum_length      = var.org_password_minimum_length
  password_require_lowercase   = var.org_password_require_lowercase
  password_require_numbers     = var.org_password_require_numbers
  password_require_symbols     = var.org_password_require_symbols
  password_require_uppercase   = var.org_password_require_uppercase
  reply_to_email_address       = var.org_reply_to_email_address
  default_tags                 = var.default_tags
  verification_email_message   = var.org_verification_email_message
  verification_email_subject   = var.org_verification_email_subject
  post_confirmation_lambda_arn = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${var.aws_env}-lambda-init-profile"
}
