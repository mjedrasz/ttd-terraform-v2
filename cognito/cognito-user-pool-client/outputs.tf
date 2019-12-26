output "web_client_id" {
  value = module.web_client.user_pool_client_id
}

output "mobile_client_id" {
  value = module.mobile_client.user_pool_client_id
}
