locals {
  tags = {
    Terraform   = "true"
    Environment = "api"
  }
  api_prefix = "api"
  api_url    = format("%s.%s", local.api_prefix, var.domain_name)

  layers = {
    "ssm-access"  = "For fetching SSM parameter store values."
    "web-request" = "For making external API calls."
  }

  functions = {
    "get-bucket-list-items"         = "Fetches bucket list items from DynamoDB."
    "get-places"                    = "Fetches places details from DynamoDB."
    "get-spotify-currently-playing" = "Fetches currently playing Spotify music from Spotify API."
    "get-weather"                   = "Fetches current weather from OpenWeatherMap API."
  }

  output_type = "zip"
}
