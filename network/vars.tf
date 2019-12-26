variable "aws_region" {
  description = "The AWS region to deploy to (e.g. us-west-1)"
}

variable "aws_env" {
  description = "The AWS environemtn to deploy to (e.g. dev)"
}

variable "default_tags" {
  type = "map"
  default = {}
}

variable "vpc_cidr" {
  description = "VPC cidr block. Example: 10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name of VPC"
}

variable "destination_cidr_block" {
  default     = "0.0.0.0/0"
  description = "Specify all traffic to be routed either trough Internet Gateway or NAT to access the internet"
}

variable "private_subnet_cidrs" {
  type        = "list"
  description = "List of private cidrs, for every avalibility zone you want you need one. Example: 10.0.0.0/24 and 10.0.1.0/24"
}

variable "private_db_subnet_cidrs" {
  type        = "list"
  description = "List of private cidrs for RDS or other DB engine, for every avalibility zone you want you need one. Example: 10.0.0.0/24 and 10.0.1.0/24"
}

variable "public_subnet_cidrs" {
  type        = "list"
  description = "List of public cidrs, for every avalibility zone you want you need one. Example: 10.0.0.0/24 and 10.0.1.0/24"
}

variable "availability_zones" {
  type        = "list"
  description = "List of avalibility zones you want. Example: eu-west-1a and eu-west-1b"
}

variable "depends_id" {}

variable "public_key" {}