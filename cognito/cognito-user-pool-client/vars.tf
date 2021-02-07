variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
}

variable "aws_env" {
  description = "The AWS environemtn to deploy to (e.g. dev)"
}

variable "mobile_client_name" {
  description = "Mobile client name"
}

variable "mobile_client_callback_urls" {
  type = list
  description = "Mobile client callback urls"
}

variable "mobile_client_logout_urls" {
  type = list
  description = "Moblie client logout urls"
}

variable "web_client_name" {
  description = "Mobile client name"
}

variable "web_client_callback_urls" {
  type = list
  description = "Mobile client callback urls"
}

variable "web_client_logout_urls" {
  type = list
  description = "Moblie client logout urls"
}

variable "route53" {
  type = bool
  description = "Route53 enabled"
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
