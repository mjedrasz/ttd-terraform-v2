variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
}

variable "aws_env" {
  description = "The AWS environemtn to deploy to (e.g. dev)"
}

variable "assets_aliases" {
  type        = list
  description = "The list of CNAMES"
}

variable "domain" {
  description = "The name of domain"
}

variable "organiser_aliases" {
  type        = list
  description = "The list of CNAMES"
}

variable "pwa_aliases" {
  type        = list
  description = "The list of CNAMES"
}

variable "cache_min_ttl" {
  default     = 0
  description = "Cache min TTL"
}

variable "cache_default_ttl" {
  default     = 3600
  description = "Cache default TTL"
}

variable "cache_max_ttl" {
  default     = 86400
  description = "Cache max TTL"
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
  type = map
  default = {}
}
