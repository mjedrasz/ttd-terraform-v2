module "mobile_client" {
  source                           = "./user-pool-client"
  user_pool_client_name            = "${var.aws_env}-${var.mobile_client_name}"
  user_pool_client_callback_urls   = var.route53 ? var.mobile_client_callback_urls : concat(var.mobile_client_callback_urls, ["https://${data.terraform_remote_state.cloudfront.outputs.pwa_ui_distribution_domain_name}"])
  user_pool_client_logout_urls     = var.route53 ? var.mobile_client_logout_urls : concat(var.mobile_client_logout_urls, ["https://${data.terraform_remote_state.cloudfront.outputs.pwa_ui_distribution_domain_name}"])
  user_pool_id                     = data.terraform_remote_state.cognito_user_pool.outputs.cognito_user_pool_id
}

#assuming the last element on the list should be used (any preceding urls might be for local environment, eg. http://localhost:8081)
resource "aws_ssm_parameter" "user_sign_in_callback_url" {
  count     = var.route53 ? 1 : 0
  name      = "/${var.aws_env}/cognito/user-pool-clients/user/sign-in-url"
  type      = "String"
  value     = element(var.mobile_client_callback_urls, length(var.mobile_client_callback_urls)-1)
  overwrite = true
}

#assuming the last element on the list should be used (any preceding urls might be for local environment, eg. http://localhost:8081)
resource "aws_ssm_parameter" "user_sign_out_callback_url" {
  count     = var.route53 ? 1 : 0
  name      = "/${var.aws_env}/cognito/user-pool-clients/user/sign-out-url"
  type      = "String"
  value     = element(var.mobile_client_logout_urls, length(var.mobile_client_logout_urls)-1)
  overwrite = true
}

resource "aws_ssm_parameter" "user_sign_in_callback_url_cloudfront" {
  count     = var.route53 ? 0 : 1
  name      = "/${var.aws_env}/cognito/user-pool-clients/user/sign-in-url"
  type      = "String"
  value     = "https://${data.terraform_remote_state.cloudfront.outputs.pwa_ui_distribution_domain_name}"
  overwrite = true
}

resource "aws_ssm_parameter" "user_sign_out_callback_url_cloudfront" {
  count     = var.route53 ? 0 : 1
  name      = "/${var.aws_env}/cognito/user-pool-clients/user/sign-out-url"
  type      = "String"
  value     = "https://${data.terraform_remote_state.cloudfront.outputs.pwa_ui_distribution_domain_name}"
  overwrite = true
}

resource "aws_ssm_parameter" "user_pool_client_id" {
  name  = "/${var.aws_env}/cognito/user-pool-clients/user/id"
  type  = "String"
  value = module.mobile_client.user_pool_client_id
}

