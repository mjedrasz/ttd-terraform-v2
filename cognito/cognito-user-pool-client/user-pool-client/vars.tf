variable "user_pool_client_name" {
  description = "Cognito user pool client name"
}

variable "user_pool_id" {
  description = "Cognito user pool id"
}

variable "user_pool_client_callback_urls" {
  type        = list
  description = "Cognito user pool client callback urls"
}

variable "user_pool_client_logout_urls" {
  type        = list
  description = "Cognito user pool client logout urls"
}