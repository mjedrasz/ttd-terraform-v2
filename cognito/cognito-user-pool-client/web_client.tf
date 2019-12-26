module "web_client" {
  source                           = "./user-pool-client"
  user_pool_client_name            = "${var.aws_env}-${var.web_client_name}"
  user_pool_client_callback_urls   = var.web_client_callback_urls
  user_pool_client_logout_urls     = var.web_client_logout_urls
  user_pool_id                     = data.terraform_remote_state.cognito_user_pool.outputs.cognito_org_pool_id
}

#assuming the last element on the list should be used (any preceding urls might be for local environment, eg. http://localhost:8081)
resource "aws_ssm_parameter" "org_sign_in_callback_url" {
  name  = "/${var.aws_env}/cognito/user-pool-client/org/sign-in-url"
  type  = "String"
  value = element(var.web_client_callback_urls, length(var.web_client_callback_urls)-1)
}

#assuming the last element on the list should be used (any preceding urls might be for local environment, eg. http://localhost:8081)
resource "aws_ssm_parameter" "org_sign_out_callback_url" {
  name  = "/${var.aws_env}/cognito/user-pool-client/org/sign-out-url"
  type  = "String"
  value = element(var.web_client_logout_urls, length(var.web_client_logout_urls)-1)
}

resource "aws_ssm_parameter" "org_user_pool_client_id" {
  name  = "/${var.aws_env}/cognito/org/user-pool-client/id"
  type  = "String"
  value = module.web_client.user_pool_client_id
}
