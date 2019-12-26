variable "domain" {
  default = "Cognito User Pool domain name"
}

variable "name" {
  default = "Cognito User Pool name"
}

variable "reply_to_email_address" {
  default = "Reply to email address for emails with verification codes"
}

variable "password_minimum_length" {
  default = "Minimum password length"
}

variable "password_require_lowercase" {
  default = "Passwords require lowercase characters?"
}

variable "password_require_numbers" {
  default = "Passwords require numbers characters?"
}

variable "password_require_symbols" {
  default = "Passwords require symbols characters?"
}

variable "password_require_uppercase" {
  default = "Passwords require uppercase characters?"
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

variable "default_tags" {
  type = map
  default = {}
}
