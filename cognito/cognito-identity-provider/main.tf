provider "template" {
  version = "~> 2.1"
}

provider "aws" {
  region  = var.aws_region
  version = "~> 2.7"
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

data "terraform_remote_state" "cognito_user_pool" {
  backend = "s3"
  config  = {
    bucket = var.tfstate_global_bucket
    key    = var.tfstate_cognito_user_pool_bucket
    region = var.tfstate_global_bucket_region
  }
}

