provider "template" {
}

provider "aws" {
  region  = var.aws_region

  endpoints {
    dynamodb = local.dynamodb_endpoint
  }
}
