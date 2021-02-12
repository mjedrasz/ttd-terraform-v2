resource "aws_cognito_identity_pool" "pool" {
  identity_pool_name               = "${var.aws_env}-${var.name}-identity-pool"
  allow_unauthenticated_identities = true

  cognito_identity_providers {
    client_id               = var.user_pool_client_id
    provider_name           = "cognito-idp.${var.aws_region}.amazonaws.com/${var.user_pool_id}"
    server_side_token_check = false
  }
}

resource "aws_ssm_parameter" "identity_pool_id" {
  name  = "/${var.aws_env}/cognito/identity-pools/${var.name}/id"
  type  = "String"
  value = aws_cognito_identity_pool.pool.id
}

