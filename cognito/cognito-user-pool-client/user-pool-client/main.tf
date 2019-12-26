resource "aws_cognito_user_pool_client" "client" {
  name                                 = var.user_pool_client_name
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["phone", "email", "openid", "profile", "aws.cognito.signin.user.admin"]
  user_pool_id                         = var.user_pool_id
  callback_urls                        = var.user_pool_client_callback_urls
  logout_urls                          = var.user_pool_client_logout_urls
  allowed_oauth_flows_user_pool_client = true
  supported_identity_providers         = ["Facebook", "Google"]
}

