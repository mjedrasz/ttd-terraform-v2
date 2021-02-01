variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-west-1)"
}

variable "aws_env" {
  description = "The AWS environemtn to deploy to (e.g. dev)"
}

variable "default_tags" {
  type = map
  default = {}
}

variable "override_dynamodb_endpoint" {
  default = ""
}

locals {
  dynamodb_endpoint = var.override_dynamodb_endpoint != "" ? var.override_dynamodb_endpoint : "https://dynamodb.${var.aws_region}.amazonaws.com"
}

variable "table_name" {
  description = "Table name"
}

variable "read_capacity" {
  description = "Read capacity"
}

variable "write_capacity" {
  description = "Write capacity"
}

variable "range_key" {
  description = "Range key"
  default     = ""
}

variable "hash_key" {
  description = "Hash key"
}

variable "attributes" {
  type = list(object({ name = string, type = string }))
  description = "Table schema"
}

variable "ttl_attribute_name" {
  default     = ""
  description = "Where to store TTL info"
}

variable "ttl_enabled" {
  default     = false
  description = "TTL enabled?"
}

variable "lifecycle_ignore_changes" {
  type        = list
  default     = []
  description = "Ignore the specified attributes through changes"
}

variable "stream_enabled" {
  default     = false
  description = "DynamoDb steam enabled?"
}

variable "stream_view_type" {
  default     = ""
  description = "DynamoDb steam view type, e.g. NEW_IMAGE"
}

variable "gsi" {
  type        = list
  default     = []
  description = "List of Global Secondary Indices"
}

variable "lsi" {
  type        = list
  default     = []
  description = "List of Local Secondary Indices"
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
