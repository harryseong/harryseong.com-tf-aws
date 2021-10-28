resource "aws_ssm_parameter" "idp_google_oauth_client_id" {
  name        = "/${var.domain_name}/idp/google/oauth_client_id"
  description = "Google IDP OAuth client ID."
  type        = "SecureString"
  value       = "default_value"
  overwrite   = false
  tags        = local.tags

  lifecycle {
    ignore_changes  = [value]
    prevent_destroy = true
  }
}

resource "aws_ssm_parameter" "idp_google_oauth_client_secret" {
  name        = "/${var.domain_name}/idp/google/oauth_client_secret"
  description = "Google IDP OAuth client secret."
  type        = "SecureString"
  value       = "default_value"
  overwrite   = false
  tags        = local.tags

  lifecycle {
    ignore_changes  = [value]
    prevent_destroy = true
  }
}
