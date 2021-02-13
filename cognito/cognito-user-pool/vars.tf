variable "domain" {
  default = "Cognito User Pool domain name"
}

variable "name" {
  default = "Cognito User Pool name"
}

variable "reply_to_email_address" {
  description = "Reply to email address for emails with verification codes"
  default     = 

}

variable "password_minimum_length" {
  description = "Minimum password length"
  default = 8
}

variable "password_require_lowercase" {
  description = "Passwords require lowercase characters?"
  default = false
}

variable "password_require_numbers" {
  description = "Passwords require numbers characters?"
  default = false
}

variable "password_require_symbols" {
  description = "Passwords require symbols characters?"
  default = false
}

variable "password_require_uppercase" {
  description = "Passwords require uppercase characters?"
  default = false
}

variable "post_confirmation_lambda_arn" {
  default = ""
}

variable "verification_email_subject" {
  default = "Your verification code"
}

variable "verification_email_message" {
  default = "Your verification code is {####}."
}

