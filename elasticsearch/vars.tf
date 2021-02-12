variable "domain" {
  description = "Elasticsearch domain name"
}

variable "elasticsearch_version" {
  description = "Elasticsearch version"
  default     = "6.3"
}

variable "elasticsearch_instance_type" {
  description = "Elasticsearch instance type"
  default     = "t2.small.elasticsearch"
}

variable "elasticsearch_allow_explicit_config" {
  description = "Elasticsearch instance type"
  default     = true
}

variable "elasticsearch_instance_count" {
  description = "Elasticsearch instance count"
  default     = 1
}

variable "ebs_volume_type" {
  description = "Elasticsearch EBS volume typ"
  default     = "gp2"
}

variable "ebs_volume_size" {
  description = "Elasticsearch EBS volume size"
  default     = 10
}

variable "elasticsearch_dedicated_master_enabled" {
  description = "Elasticsearch dedicated master enabled"
  default = false
}
variable "elasticsearch_dedicated_master_type" {
  description = "Elasticsearch dedicated master type"
  default = ""
}
variable "elasticsearch_dedicated_master_count" {
  description = "Elasticsearch dedicated master count"
  default = 0
}
variable "elasticsearch_zone_awareness_enabled" {
  description = "Elasticsearch zone awareness enabled"
  default = false
}
