provider "template" {
}

provider "aws" {
  region  = var.aws_region
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

data "terraform_remote_state" "cognito_user_pool" {
    backend = "s3"
    config = {
        bucket = var.tfstate_global_bucket
        key    = var.tfstate_cognito_user_pool_bucket
        region = var.tfstate_global_bucket_region
    }
}

data "terraform_remote_state" "cognito_user_pool_client" {
    backend = "s3"
    config  = {
        bucket = var.tfstate_global_bucket
        key    = var.tfstate_cognito_user_pool_client_bucket
        region = var.tfstate_global_bucket_region
    }
}

data "terraform_remote_state" "s3_assets" {
  backend = "s3"
  config = {
    bucket = var.tfstate_global_bucket
    key    = var.tfstate_s3_assets_bucket
    region = var.tfstate_global_bucket_region
  }
}

data "terraform_remote_state" "pinpoint" {
  backend = "s3"
  config = {
    bucket = var.tfstate_global_bucket
    key    = var.tfstate_pinpoint_bucket
    region = var.tfstate_global_bucket_region
  }
}
