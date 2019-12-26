variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
}

variable "aws_env" {
  description = "The AWS environemtn to deploy to (e.g. dev)"
}

variable "user_pool_domain" {
  description = "Cognito User Pool domain name"
}

variable "user_pool_name" {
  description = "Cognito User Pool name"
}

variable "org_pool_domain" {
  description = "Cognito User Pool domain name"
}

variable "org_pool_name" {
  description = "Cognito User Pool name"
}

variable "reply_to_email_address" {
  description = "Reply to email address for emails with verification codes"
}

variable "password_minimum_length" {
  description = "Minimum password length"
  default = 8
}

variable "password_require_lowercase" {
  description = "Passwords require lowercase characters?"
  default = false
}

variable "password_require_numbers" {
  description = "Passwords require numbers characters?"
  default = false
}

variable "password_require_symbols" {
  description = "Passwords require symbols characters?"
  default = false
}

variable "password_require_uppercase" {
  description = "Passwords require uppercase characters?"
  default = false
}

variable "org_reply_to_email_address" {
  description = "Reply to email address for emails with verification codes"
}

variable "org_password_minimum_length" {
  description = "Minimum password length"
  default = 8
}

variable "org_password_require_lowercase" {
  description = "Passwords require lowercase characters?"
  default = false
}

variable "org_password_require_numbers" {
  description = "Passwords require numbers characters?"
  default = false
}

variable "org_password_require_symbols" {
  description = "Passwords require symbols characters?"
  default = false
}

variable "org_password_require_uppercase" {
  description = "Passwords require uppercase characters?"
  default = false
}

variable "user_verification_email_subject" {
  default = "Your verification code"
}

variable "user_verification_email_message" {
  default = "Your verification code is {####}."
}

variable "org_verification_email_subject" {
  default = "Your verification code"
}

variable "org_verification_email_message" {
  default = "Your verification code is {####}."
}

variable "tfstate_global_bucket_region" {
  description = "Terraform bucket state region, e.g. eu-central-1"
}

variable "tfstate_global_bucket" {
  description = "Terraform remote state"
}

variable "tfstate_cognito_user_pool_bucket" {
  description = "Cognito user pool state"
}

variable "tfstate_cognito_user_pool_client_bucket" {
  description = "Cognito user pool client state"
}

variable "tfstate_s3_assets_bucket" {
  description = "S3 assets state"
}

variable "tfstate_s3_organiser_ui_bucket" {
  description = "S3 organiser assets state"
}

variable "tfstate_s3_pwa_ui_bucket" {
  description = "S3 PWA state"
}

variable "tfstate_cloudfront_bucket" {
  description = "Cloudfront state"
}

variable "tfstate_pinpoint_bucket" {
  description = "Pinpoint state"
}

variable "tfstate_dynamodb_bucket" {
  description = "Dynamodb state"
}

variable "default_tags" {
  type    = map
  default = {}
}

