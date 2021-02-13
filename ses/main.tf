resource "aws_ses_domain_identity" "ses_domain" {
  domain   = var.dns_domain
}

resource "aws_route53_record" "ses_verification_record" {
  zone_id  = data.aws_route53_zone.public_hosted_zone.id
  name     = "_amazonses.${var.dns_domain}"
  type     = "TXT"
  ttl      = "600"
  records  = [aws_ses_domain_identity.ses_domain.verification_token]
}

data "aws_route53_zone" "public_hosted_zone" {
  name     = var.public_hosted_zone
}
