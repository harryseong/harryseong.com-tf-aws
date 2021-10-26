resource "aws_ssm_parameter" "mapbox_access_token" {
  name        = "/harryseong.com/angular/${var.env}/mapbox-access-token"
  description = "MapBox access token."
  type        = "SecureString"
  value       = "default_value"
  overwrite   = false
  tags        = local.tags

  lifecycle {
    ignore_changes  = [value]
    prevent_destroy = true
  }
}

resource "aws_ssm_parameter" "aws_api_key" {
  name        = "/harryseong.com/angular/${var.env}/aws-api-key"
  description = "AWS API key to api.harryseong.com."
  type        = "SecureString"
  value       = "default_value"
  overwrite   = false
  tags        = local.tags

  lifecycle {
    ignore_changes  = [value]
    prevent_destroy = true
  }
}
