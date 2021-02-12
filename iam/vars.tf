variable "authenticated_assume_role_policy" {
  description = "Authenticated assume role policy"
}

variable "authenticated_policy" {
  description = "Authenticated policy"
}

variable "unauthenticated_assume_role_policy" {
  description = "Unathenticated assume role policy"
}

variable "unauthenticated_policy" {
  description = "Unauthenticated policy"
}

variable "name" {
  description = "Resource differentiating name"
}

variable "identity_pool_id" {
  description = "Cognito identity pool id"
}
