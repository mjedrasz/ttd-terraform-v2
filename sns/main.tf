provider "template" {
}

provider "aws" {
  region  = var.aws_region

}




resource "aws_sns_topic" "fanout" {
  name = "${var.aws_env}-fanout"
}

resource "aws_ssm_parameter" "fanout_arn" {
  name  = "/${var.aws_env}/sns/topics/fanout/arn"
  type  = "String"
  value = aws_sns_topic.fanout.arn
}
