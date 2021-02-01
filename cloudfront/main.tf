provider "template" {

}

provider "aws" {
  region  = var.aws_region

}

provider "aws" {
  alias   = "us-east-1"
  region  = "us-east-1"
}



data "aws_acm_certificate" "us-east-1_ssl_certificate" {
  domain   = var.domain
  provider = aws.us-east-1
}

