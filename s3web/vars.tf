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
