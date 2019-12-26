output "cognito_user_pool_id" {
  value = module.user-pool.cognito_user_pool_id
}

output "cognito_org_pool_id" {
  value = module.org-pool.cognito_user_pool_id
}
