resource "aws_cognito_identity_pool" "main_idp" {
  identity_pool_name               = var.domain_name
  allow_unauthenticated_identities = false
  allow_classic_flow               = false
  tags                             = local.tags

  supported_login_providers = {
    "accounts.google.com" = data.aws_ssm_parameter.google_oauth_client_id.value
  }
}
