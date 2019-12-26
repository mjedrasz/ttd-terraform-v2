variable "user_pool_id" {
  description = "Cognito user pool id"
}

variable "provider_name" {
  description = "Identity provider name"
}

variable "provider_type" {
  description = "Identity provider type"
}

variable "authorize_scopes" {
  description = "Authorize scopes"
}

variable "attribute_mapping" {
  type        = map
  description = "Attribute mapping"
}

variable "client_id" {
  description = "Client id"
}

variable "client_secret" {
  description = "Client secret"
  
}