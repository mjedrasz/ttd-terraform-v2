provider "template" {
}

provider "aws" {
  region  = var.aws_region

}



resource "aws_route53_record" "assets_record" {
  zone_id = data.aws_route53_zone.public_hosted_zone.zone_id
  name    = var.assets_cname
  type    = "A"

  alias {
      name                   = data.terraform_remote_state.cloudfront.outputs.assets_distribution_domain_name
      zone_id                = data.terraform_remote_state.cloudfront.outputs.assets_distribution_hosted_zone_id
      evaluate_target_health = true
  }
}

resource "aws_route53_record" "organiser_ui_record" {
  zone_id = data.aws_route53_zone.public_hosted_zone.zone_id
  name    = var.organiser_ui_cname
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.organiser_ui_distribution_domain_name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.organiser_ui_distribution_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "pwa_ui_record" {
  zone_id = data.aws_route53_zone.public_hosted_zone.zone_id
  name    = var.pwa_ui_cname
  type    = "A"

  alias {
    name                   = data.terraform_remote_state.cloudfront.outputs.pwa_ui_distribution_domain_name
    zone_id                = data.terraform_remote_state.cloudfront.outputs.pwa_ui_distribution_hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_ssm_parameter" "asset_record" {
  name  = "/${var.aws_env}/route53/assets/name"
  type  = "String"
  value = aws_route53_record.assets_record.name
}

data "aws_route53_zone" "public_hosted_zone" {
  name = var.public_hosted_zone
}

data "terraform_remote_state" "cloudfront" {
  backend = "s3"
  config = {
    bucket = var.tfstate_global_bucket
    key    = var.tfstate_cloudfront_bucket
    region = var.tfstate_global_bucket_region
  }
}
