variable "domain_name" {
  description = "Domain name"
}

variable "origin_id" {
  description = "Origin id"
}

variable "origin_access_identity" {
  description = "Origin access identity"
}

variable "aliases" {
  type        = list
  description = "Alternative names - CNAMES list"
}

variable "target_origin_id" {
  description = "Target origin id"
}

variable "acm_certificate_arn" {
  description = "Custom SSL certificate ARN"
  default = ""
}

variable "cache_min_ttl" {
  default = 0
  description = "Cache min TTL"
}

variable "cache_default_ttl" {
  default = 3600
  description = "Cache default TTL"
}

variable "cache_max_ttl" {
  default = 86400
  description = "Cache max TTL"
}

variable "tags" {
  type    = map
  default = {}
}
