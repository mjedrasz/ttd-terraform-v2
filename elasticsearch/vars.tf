variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-east-1)"
}

variable "aws_env" {
  description = "The AWS environemtn to deploy to (e.g. dev)"
}

variable "domain" {
  description = "Elasticsearch domain name"
}

variable "elasticsearch_version" {
  description = "Elasticsearch version"
  default     = "6.3"
}

variable "elasticsearch_instance_type" {
  description = "Elasticsearch instance type"
  default     = "t2.small.elasticsearch"
}

variable "elasticsearch_allow_explicit_config" {
  description = "Elasticsearch instance type"
  default     = true
}

variable "default_tags" {
  type = map
  default = {}
}

variable "elasticsearch_instance_count" {
  description = "Elasticsearch instance count"
  default     = 1
}

variable "ebs_volume_type" {
  description = "Elasticsearch EBS volume typ"
  default     = "gp2"
}

variable "ebs_volume_size" {
  description = "Elasticsearch EBS volume size"
  default     = 10
}

variable "elasticsearch_dedicated_master_enabled" {
  description = "Elasticsearch dedicated master enabled"
  default = false
}
variable "elasticsearch_dedicated_master_type" {
  description = "Elasticsearch dedicated master type"
  default = ""
}
variable "elasticsearch_dedicated_master_count" {
  description = "Elasticsearch dedicated master count"
  default = 0
}
variable "elasticsearch_zone_awareness_enabled" {
  description = "Elasticsearch zone awareness enabled"
  default = false
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
