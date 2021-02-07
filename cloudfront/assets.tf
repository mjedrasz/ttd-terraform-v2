module "assets-distribution" {
  source                 = "./distribution"
  domain_name            = data.terraform_remote_state.s3_assets.outputs.bucket_domain_name
  origin_id              = data.terraform_remote_state.s3_assets.outputs.bucket_domain_name
  origin_access_identity = data.terraform_remote_state.s3_assets.outputs.cloudfront_access_identity_path
  aliases                = var.assets_aliases
  target_origin_id       = data.terraform_remote_state.s3_assets.outputs.bucket_domain_name
  acm_certificate_arn    = length(var.assets_aliases) > 0 ? data.aws_acm_certificate.us-east-1_ssl_certificate[0].arn : ""
  cache_min_ttl          = var.cache_min_ttl
  cache_default_ttl      = var.cache_default_ttl
  cache_max_ttl          = var.cache_max_ttl
}

#data "aws_caller_identity" "current" {}

data "terraform_remote_state" "s3_assets" {
  backend = "s3"
  config = {
    bucket = var.tfstate_global_bucket
    key    = var.tfstate_s3_assets_bucket
    region = var.tfstate_global_bucket_region
  }
}
