provider "template" {
}

provider "aws" {
  region  = var.aws_region

}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

resource "aws_sqs_queue" "email_queue" {
  name                        = "${var.aws_env}-email-queue"
  delay_seconds               = var.delay_seconds
  max_message_size            = var.max_message_size
  message_retention_seconds   = var.message_retention_seconds
  receive_wait_time_seconds   = var.receive_wait_time_seconds
  redrive_policy              = var.redrive_policy
  fifo_queue                  = var.fifo_queue
  content_based_deduplication = var.content_based_deduplication
  tags                        = var.default_tags
}

resource "aws_sqs_queue" "push_message_queue" {
  name                        = "${var.aws_env}-push-message-queue"
  delay_seconds               = var.delay_seconds
  max_message_size            = var.max_message_size
  message_retention_seconds   = var.message_retention_seconds
  receive_wait_time_seconds   = var.receive_wait_time_seconds
  redrive_policy              = var.redrive_policy
  fifo_queue                  = var.fifo_queue
  content_based_deduplication = var.content_based_deduplication
  tags                        = var.default_tags
}