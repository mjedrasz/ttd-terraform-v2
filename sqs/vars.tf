variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-west-1)"
}

variable "aws_env" {
  description = "The AWS environemtn to deploy to (e.g. dev)"
}

variable "delay_seconds" {
  description = "Delay in seconds"
  default     = 0
}

variable "max_message_size" {
  description = "Max message size"
  default     = 262144 #256kB
}

variable "message_retention_seconds" {
  description = "Message retention in seconds"
  default     = 345600 #4 days
}

variable "receive_wait_time_seconds" {
  description = "Receive wait time in seconds"
  default     = 0
}

variable "redrive_policy" {
  description = "Redrive policy"
  default     = ""
}

variable "fifo_queue" {
  description = "Is FIFO queue?"
  default     = false
}

variable "content_based_deduplication" {
  description = "Content based deduplication"
  default     = false
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
