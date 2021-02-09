
data "aws_ssm_parameter" "google_client_id" {
  name = "/${var.aws_env}/cognito/identity-providers/google/client-id"
}

data "aws_ssm_parameter" "google_client_secret" {
  name = "/${var.aws_env}/cognito/identity-providers/google/client-secret"
}

module "google" {
  source           = "./identity-provider"
  provider_name    = "Google"
  provider_type    = "Google"
  user_pool_id     = data.terraform_remote_state.cognito_user_pool.outputs.cognito_user_pool_id
  authorize_scopes = "email openid"
  client_id        = data.aws_ssm_parameter.google_client_id.value
  client_secret    = data.aws_ssm_parameter.google_client_secret.value
  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}

module "org-google" {
  source           = "./identity-provider"
  provider_name    = "Google"
  provider_type    = "Google"
  user_pool_id     = data.terraform_remote_state.cognito_user_pool.outputs.cognito_org_pool_id
  authorize_scopes = "email openid"
  client_id        = data.aws_ssm_parameter.google_client_id.value
  client_secret    = data.aws_ssm_parameter.google_client_secret.value
  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}
