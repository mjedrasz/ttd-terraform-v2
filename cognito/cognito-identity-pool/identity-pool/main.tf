
resource "aws_cognito_identity_pool" "pool" {
  identity_pool_name               = var.identity_pool_name
  allow_unauthenticated_identities = true

  cognito_identity_providers {
    client_id               = var.identity_provider_client_id
    provider_name           = var.identity_provider_name
    server_side_token_check = false
  }
}
