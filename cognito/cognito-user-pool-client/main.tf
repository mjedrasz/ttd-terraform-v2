resource "aws_cognito_user_pool_client" "client" {
  name                                 = "${var.aws_env}-${var.client_name}"
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["phone", "email", "openid", "profile", "aws.cognito.signin.user.admin"]
  user_pool_id                         = var.user_pool_id
  callback_urls                        = var.route53 ? var.callback_urls : concat(var.callback_urls, ["https://${var.distribution_domain_name}"])
  logout_urls                          = var.route53 ? var.logout_urls : concat(var.logout_urls, ["https://${var.distribution_domain_name}"])
  allowed_oauth_flows_user_pool_client = true
  supported_identity_providers         = ["Facebook", "Google"]
}

#assuming the last element on the list should be used (any preceding urls might be for local environment, eg. http://localhost:8081)
resource "aws_ssm_parameter" "callback_url" {
  count     = var.route53 ? 1 : 0
  name      = "/${var.aws_env}/cognito/user-pool-clients/${var.client_name}/sign-in-url"
  type      = "String"
  value     = element(var.callback_urls, length(var.callback_urls)-1)
  overwrite = true
}

#assuming the last element on the list should be used (any preceding urls might be for local environment, eg. http://localhost:8081)
resource "aws_ssm_parameter" "logout_url" {
  count     = var.route53 ? 1 : 0
  name      = "/${var.aws_env}/cognito/user-pool-clients/${var.client_name}/sign-out-url"
  type      = "String"
  value     = element(var.logout_urls, length(var.logout_urls)-1)
  overwrite = true
}

resource "aws_ssm_parameter" "callback_url_cloudfront" {
  count     = var.route53 ? 0 : 1
  name      = "/${var.aws_env}/cognito/user-pool-clients/${var.client_name}/sign-in-url"
  type      = "String"
  value     = "https://${var.distribution_domain_name}"
  overwrite = true
}

resource "aws_ssm_parameter" "logout_url_cloudfront" {
  count     = var.route53 ? 0 : 1
  name      = "/${var.aws_env}/cognito/user-pool-clients/${var.client_name}/sign-out-url"
  type      = "String"
  value     = "https://${var.distribution_domain_name}"
  overwrite = true
}

resource "aws_ssm_parameter" "user_pool_client_id" {
  name  = "/${var.aws_env}/cognito/user-pool-clients/${var.client_name}/id"
  type  = "String"
  value = aws_cognito_user_pool_client.client.id
}