provider "template" {
}

provider "aws" {
  region  = var.aws_region

}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

module "vpc" {
  source = "vpc"

  vpc_name    = var.vpc_name
  cidr        = var.vpc_cidr
  tags        = var.default_tags
}

module "private_subnet" {
  source = "subnet"

  name               = "${var.vpc_name}_private_subnet"
  vpc_id             = module.vpc.id
  cidrs              = var.private_subnet_cidrs
  availability_zones = var.availability_zones
}

module "private_db_subnet" {
  source = "subnet"

  name               = "${var.vpc_name}_private_db_subnet"
  vpc_id             = module.vpc.id
  cidrs              = var.private_db_subnet_cidrs
  availability_zones = var.availability_zones
}

module "public_subnet" {
  source = "subnet"

  name               = "${var.vpc_name}_public_subnet"
  vpc_id             = module.vpc.id
  cidrs              = var.public_subnet_cidrs
  availability_zones = var.availability_zones
}

module "nat" {
  source = "nat_gateway"

  subnet_ids   = module.public_subnet.ids
  subnet_count = length(var.public_subnet_cidrs)
}

resource "aws_route" "public_igw_route" {
  count                  = length(var.public_subnet_cidrs)
  route_table_id         = element(module.public_subnet.route_table_ids, count.index)
  gateway_id             = module.vpc.igw
  destination_cidr_block = var.destination_cidr_block
}

resource "aws_route" "private_nat_route" {
  count                  = length(var.private_subnet_cidrs)
  route_table_id         = element(module.private_subnet.route_table_ids, count.index)
  nat_gateway_id         = element(module.nat.ids, count.index)
  destination_cidr_block = var.destination_cidr_block
}

resource "aws_vpc_endpoint" "vpc_endpoint" {
  vpc_id          = module.vpc.id
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  route_table_ids = [module.private_subnet.route_table_ids]
}

# Creating a NAT Gateway takes some time. Some services need the internet (NAT Gateway) before proceeding. 
# Therefore we need a way to depend on the NAT Gateway in Terraform and wait until is finished. 
# Currently Terraform does not allow module dependency to wait on.
# Therefore we use a workaround described here: https://github.com/hashicorp/terraform/issues/1178#issuecomment-207369534

resource "null_resource" "dummy_dependency" {
  depends_on = [module.nat]
}
