
data "aws_ssm_parameter" "facebook_client_id" {
  name = "/${var.aws_env}/cognito/identity-provider/facebook/client-id"
}

data "aws_ssm_parameter" "facebook_client_secret" {
  name = "/${var.aws_env}/cognito/identity-provider/facebook/client-secret"
}

module "facebook" {
  source            = "./identity-provider"
  provider_name     = "Facebook"
  provider_type     = "Facebook"
  user_pool_id      = data.terraform_remote_state.cognito_user_pool.outputs.cognito_user_pool_id
  authorize_scopes  = "public_profile, email"
  client_id         = data.aws_ssm_parameter.facebook_client_id.value
  client_secret     = data.aws_ssm_parameter.facebook_client_secret.value
  attribute_mapping = {
                        email    = "email"
                        username = "id"
                      }
}

module "org-facebook" {
  source            = "./identity-provider"
  provider_name     = "Facebook"
  provider_type     = "Facebook"
  user_pool_id      = data.terraform_remote_state.cognito_user_pool.outputs.cognito_org_pool_id
  authorize_scopes  = "public_profile, email"
  client_id         = data.aws_ssm_parameter.facebook_client_id.value
  client_secret     = data.aws_ssm_parameter.facebook_client_secret.value
  attribute_mapping = {
                        email    = "email"
                        username = "id"
                      }
}
