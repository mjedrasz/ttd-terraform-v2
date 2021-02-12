provider "aws" {
  alias   = "us-east-1"
  region  = "us-east-1"
}

resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name = var.bucket_domain_name
    origin_id   = var.origin_id

    s3_origin_config {
      origin_access_identity = var.origin_access_identity
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  aliases = var.aliases

  default_cache_behavior {
    target_origin_id = var.target_origin_id
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    compress         = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = var.cache_min_ttl
    default_ttl            = var.cache_default_ttl
    max_ttl                = var.cache_max_ttl
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = length(var.aliases) == 0
    acm_certificate_arn    = length(var.aliases) > 0 ? data.aws_acm_certificate.us-east-1_ssl_certificate[0].arn : ""
  }

  tags = var.default_tags
}

resource "aws_ssm_parameter" "distribution_cloudfront_domain" {
  name      = "/${var.aws_env}/s3/${var.name}/domain"
  type      = "String"
  value     = aws_cloudfront_distribution.distribution.domain_name
  overwrite = true
}

data "aws_acm_certificate" "us-east-1_ssl_certificate" {
  count    = var.domain == "" ? 0 : 1
  domain   = var.domain
  provider = aws.us-east-1
}