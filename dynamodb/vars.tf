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
  default = 1
}

variable "write_capacity" {
  description = "Write capacity"
  default = 1
}

variable "billing_mode" {
  description = "Billing mode"  
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
