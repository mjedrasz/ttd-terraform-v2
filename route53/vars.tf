variable "public_hosted_zone" {
  description = "Public hosted zone in Route53"
}

variable "cname" {
  description = "CNAME"
}

variable "name" {
  description = "Resource differentiating name"
}

variable "distribution_domain_name" {
  description = "Cloudfront distribution domain name"
}

variable "distribution_hosted_zone_id" {
  description = "Cloudfront distribution hosted zone id"
}