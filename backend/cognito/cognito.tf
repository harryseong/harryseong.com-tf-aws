# resource "aws_cognito_identity_pool" "main_idp" {
#   identity_pool_name               = var.domain_name
#   allow_unauthenticated_identities = false
#   allow_classic_flow               = false
#   tags                             = local.tags

#   supported_login_providers = {
#     "accounts.google.com" = data.aws_ssm_parameter.google_oauth_client_id.value
#   }
# }
#

resource "aws_cognito_user_pool" "main" {
  name = var.domain_name
  tags = local.tags
}

resource "aws_cognito_user_pool_domain" "main" {
  domain          = local.auth_url
  user_pool_id    = aws_cognito_user_pool.main.id
  certificate_arn = module.acm_certificate.acm_certificate_arn
}
