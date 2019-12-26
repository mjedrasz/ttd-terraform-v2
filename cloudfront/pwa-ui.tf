module "pwa-ui-distribution" {
  source                 = "./distribution"
  domain_name            = data.terraform_remote_state.s3_pwa_ui.outputs.bucket_domain_name
  origin_id              = data.terraform_remote_state.s3_pwa_ui.outputs.bucket_domain_name
  origin_access_identity = data.terraform_remote_state.s3_pwa_ui.outputs.cloudfront_access_identity_path
  aliases                = var.pwa_aliases
  target_origin_id       = data.terraform_remote_state.s3_pwa_ui.outputs.bucket_domain_name
  acm_certificate_arn    = data.aws_acm_certificate.us-east-1_ssl_certificate.arn
  cache_min_ttl          = var.cache_min_ttl
  cache_default_ttl      = var.cache_default_ttl
  cache_max_ttl          = var.cache_max_ttl
}

data "terraform_remote_state" "s3_pwa_ui" {
  backend = "s3"
  config = {
    bucket = var.tfstate_global_bucket
    key    = var.tfstate_s3_pwa_ui_bucket
    region = var.tfstate_global_bucket_region
  }
}

resource "aws_ssm_parameter" "pwa_ui_distribution_id" {
  name  = "/${var.aws_env}/cloudfront/pwa-ui/distribution/id"
  type  = "String"
  value = module.pwa-ui-distribution.distribution_id
}