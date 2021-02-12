resource "aws_pinpoint_app" "pinpoint" {
  name = "${var.aws_env}-ttd"
}

resource "aws_ssm_parameter" "pinpoint_app_id" {
  name  = "/${var.aws_env}/pinpoint/app/id"
  type  = "String"
  value = aws_pinpoint_app.pinpoint.id
}
