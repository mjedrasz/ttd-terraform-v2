variable "client_name" {
  description = "Cognito user pool client name"
}

variable "user_pool_id" {
  description = "Cognito user pool id"
}

variable "distribution_domain_name" {
  description = "Cloudfront distribution domain name"
}

variable "callback_urls" {
  type        = list
  description = "Cognito user pool client callback urls"
}

variable "logout_urls" {
  type        = list
  description = "Cognito user pool client logout urls"
}

variable "route53" {
  type = bool
  description = "Route53 enabled"
}