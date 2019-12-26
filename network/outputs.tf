output "vpc_id" {
  value = module.vpc.id
}

output "vpc_endpoint_id" {
  value = aws_vpc_endpoint.vpc_endpoint.id
}

output "vpc_cidr" {
  value = module.vpc.cidr_block
}

output "private_subnet_ids" {
  value = module.private_subnet.ids
}

output "private_subnet_cidrs" {
  value = var.private_subnet_cidrs
}

output "private_db_subnet_ids" {
  value = module.private_db_subnet.ids
}

output "public_subnet_ids" {
  value = module.public_subnet.ids
}

output "public_subnet_cidrs" {
  value = var.public_subnet_cidrs
}

output "bastion_eip" {
  value = aws_eip.bastion_eip.public_ip
}

output "bastion_private_ip" {
  value = aws_instance.db_bastion.private_ip
}

output "depends_id" {
  value = null_resource.dummy_dependency.id
}
