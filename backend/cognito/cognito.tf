resource "aws_cognito_user_pool" "main" {
  name = var.domain_name
  tags = local.tags
}

resource "aws_cognito_user_pool_domain" "main" {
  domain          = local.auth_url
  user_pool_id    = aws_cognito_user_pool.main.id
  certificate_arn = module.acm_certificate.acm_certificate_arn
}

resource "aws_cognito_user_pool_client" "client" {
  name                         = "client"
  user_pool_id                 = aws_cognito_user_pool.main.id
  supported_identity_providers = ["Google"]

  allowed_oauth_flows_user_pool_client = true
  explicit_auth_flows                  = ["ALLOW_CUSTOM_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["openid"]

  callback_urls        = ["https://www.${var.domain_name}/", "https://test.${var.domain_name}/", "http://localhost:4200/"]
  default_redirect_uri = "https://www.${var.domain_name}/"
  logout_urls          = ["https://www.${var.domain_name}/", "https://test.${var.domain_name}/", "http://localhost:4200/"]
}
