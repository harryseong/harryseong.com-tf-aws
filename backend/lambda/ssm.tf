resource "aws_ssm_parameter" "spotify_client_id" {
  name        = "/${var.domain_name}/api/spotify/client_id"
  description = "Spotify API client ID."
  type        = "SecureString"
  value       = "default_value"
  overwrite   = false
  tags        = local.tags

  lifecycle {
    ignore_changes  = [value]
    prevent_destroy = true
  }
}

resource "aws_ssm_parameter" "spotify_client_refresh_token" {
  name        = "/${var.domain_name}/api/spotify/client_refresh_token"
  description = "Spotify API client refresh token."
  type        = "SecureString"
  value       = "default_value"
  overwrite   = false
  tags        = local.tags

  lifecycle {
    ignore_changes  = [value]
    prevent_destroy = true
  }
}

resource "aws_ssm_parameter" "spotify_client_secret" {
  name        = "/${var.domain_name}/api/spotify/client_secret"
  description = "Spotify API client secret."
  type        = "SecureString"
  value       = "default_value"
  overwrite   = false
  tags        = local.tags

  lifecycle {
    ignore_changes  = [value]
    prevent_destroy = true
  }
}

resource "aws_ssm_parameter" "open_weather_map_app_id" {
  name        = "/${var.domain_name}/api/open_weather_map/app_id"
  description = "OpenWeatherMap API app ID."
  type        = "SecureString"
  value       = "default_value"
  overwrite   = false
  tags        = local.tags

  lifecycle {
    ignore_changes  = [value]
    prevent_destroy = true
  }
}
