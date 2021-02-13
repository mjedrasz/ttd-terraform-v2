variable "aws_ses_region" {
  description = "The AWS region to deploy to (e.g. us-west-1)"
}

variable "public_hosted_zone" {
  description = "Public hosted zone in Route53"
}

variable "dns_domain" {
  description = "The name of the DNS domain"
}
