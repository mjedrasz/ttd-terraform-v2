resource "aws_cognito_identity_provider" "idp" {
  user_pool_id = var.user_pool_id
  provider_name = var.provider_name
  provider_type = var.provider_type

  provider_details = merge(var.provider_details, {
    authorize_scopes = var.authorize_scopes
    client_id        = data.aws_ssm_parameter.client_id.value
    client_secret    = data.aws_ssm_parameter.client_secret.value
  })

  attribute_mapping = var.attribute_mapping

}

data "aws_ssm_parameter" "client_id" {
  name = "/${var.aws_env}/cognito/identity-providers/${lower(var.provider_name)}/client-id"
}

data "aws_ssm_parameter" "client_secret" {
  name = "/${var.aws_env}/cognito/identity-providers/${lower(var.provider_name)}/client-secret"
}
