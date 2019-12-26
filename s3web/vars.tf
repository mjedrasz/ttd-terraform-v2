variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
}

variable "aws_env" {
  description = "The AWS environemtn to deploy to (e.g. dev)"
}

variable "bucket_name" {
  description = "bucket name - see https://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html"
}

variable "ssm_bucket_name" {
  description = "name of the bucket in SSM"
  default = ""
}

variable "versioning_enabled" {
  default     = false
  description = "S3 versioning enabled flag"
}

variable "cors_allowed_headers" {
  type        = list
  description = "CORS allowed headers"
}

variable "cors_allowed_methods" {
  type        = list
  description = "CORS allowed methods"
}

variable "cors_allowed_origins" {
  type        = list
  description = "CORS allowed origins"
}

variable "cors_expose_headers" {
  type        = list
  default     = ["ETag"]
  description = "CORS exposed headers"
}

variable "cors_max_age_seconds" {
  default     = "3000"
  description = "CORS max age in seconds"
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

}

variable "default_tags" {
  type    = map
  default = {}
}
