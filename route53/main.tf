resource "aws_route53_record" "record" {
  count   = var.dns_domain == "" ? 0 : 1
  zone_id = data.aws_route53_zone.public_hosted_zone[0].zone_id
  name    = var.cname
  type    = "A"

  alias {
      name                   = var.distribution_domain_name
      zone_id                = var.distribution_hosted_zone_id
      evaluate_target_health = true
  }
}

resource "aws_ssm_parameter" "domain_route53" {
  count     = var.dns_domain == "" ? 0 : 1
  name      = "/${var.aws_env}/s3/${var.name}/domain"
  type      = "String"
  value     = aws_route53_record.record.name
  overwrite = true
}

data "aws_route53_zone" "public_hosted_zone" {
  count  = var.dns_domain == "" ? 0 : 1
  name   = var.public_hosted_zone
}
