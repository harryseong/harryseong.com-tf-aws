output "cognito_user_pool_client_id" {
  description = "Cognito user pool client ID."
  value       = aws_cognito_user_pool_client.client.id
}

output "cognito_user_pool_endpoint" {
  description = "Cognito user pool endpoint."
  value       = aws_cognito_user_pool.main.endpoint
}
