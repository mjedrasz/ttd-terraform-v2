provider "template" {
}

provider "aws" {
  region  = var.aws_region

}



resource "aws_cloudwatch_log_group" "application_logs" {
  name = "/aws/aes/domains/${var.aws_env}-ttd/application-logs"
}

resource "aws_cloudwatch_log_resource_policy" "application_logs_policy" {
  policy_name = "${var.aws_env}-es-application-logs-policy"

  policy_document = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": [
        "logs:PutLogEvents",
        "logs:PutLogEventsBatch",
        "logs:CreateLogStream"
      ],
      "Resource": "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.application_logs.name}:*"
    }
  ]
}
CONFIG
}

resource "aws_cloudwatch_log_group" "slow_search_logs" {
  name = "/aws/aes/domains/${var.aws_env}-ttd/search-logs"
}

resource "aws_cloudwatch_log_resource_policy" "slow_search_logs_policy" {
  policy_name = "${var.aws_env}-es-slow-search-logs-policy"

  policy_document = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": [
        "logs:PutLogEvents",
        "logs:PutLogEventsBatch",
        "logs:CreateLogStream"
      ],
      "Resource": "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.slow_search_logs.name}:*"
    }
  ]
}
CONFIG
}

resource "aws_cloudwatch_log_group" "slow_index_logs" {
  name = "/aws/aes/domains/${var.aws_env}-ttd/index-logs"
}

resource "aws_cloudwatch_log_resource_policy" "slow_index_logs_policy" {
  policy_name = "${var.aws_env}-es-slow-index-policy"

  policy_document = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": [
        "logs:PutLogEvents",
        "logs:PutLogEventsBatch",
        "logs:CreateLogStream"
      ],
      "Resource": "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:${aws_cloudwatch_log_group.slow_index_logs.name}:*"
    }
  ]
}
CONFIG
}

resource "aws_elasticsearch_domain" "es" {
  domain_name           = "${var.aws_env}-${var.domain}"
  elasticsearch_version = var.elasticsearch_version

  cluster_config {
    instance_type            = var.elasticsearch_instance_type
    instance_count           = var.elasticsearch_instance_count
    dedicated_master_enabled = var.elasticsearch_dedicated_master_enabled
    dedicated_master_type    = var.elasticsearch_dedicated_master_type
    dedicated_master_count   = var.elasticsearch_dedicated_master_count
    zone_awareness_enabled   = var.elasticsearch_zone_awareness_enabled
  }

  ebs_options {
    ebs_enabled = true
    volume_type = var.ebs_volume_type
    volume_size = var.ebs_volume_size
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags = var.default_tags

  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.application_logs.arn
    log_type                 = "ES_APPLICATION_LOGS"
  }

  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.slow_search_logs.arn
    log_type                 = "SEARCH_SLOW_LOGS"
  }

  log_publishing_options {
    cloudwatch_log_group_arn = aws_cloudwatch_log_group.slow_index_logs.arn
    log_type                 = "INDEX_SLOW_LOGS"
  }
}

resource "aws_ssm_parameter" "es_domain" {
  name  = "/${var.aws_env}/elasticsearch/domain"
  type  = "String"
  value = aws_elasticsearch_domain.es.domain_name
}

resource "aws_ssm_parameter" "es_endpoint" {
  name  = "/${var.aws_env}/elasticsearch/endpoint"
  type  = "String"
  value = aws_elasticsearch_domain.es.endpoint
}

data "aws_caller_identity" "current" {}