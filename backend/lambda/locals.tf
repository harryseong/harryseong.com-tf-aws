locals {
  tags = {
    Terraform   = "true"
    Environment = var.env
  }
  api_prefix = "api"
  api_url    = format("%s.%s", local.api_prefix, var.domain_name)

  layer-configs = {
    ssm-access  = { description = "For fetching SSM parameter store values." }
    web-request = { description = "For making external API calls." }
  }

  function-configs = {
    get-bucket-list-items = {
      description = "Fetches bucket list items from DynamoDB."
      environment_variables = {
        "DYNAMODB_TABLE" = "bucket_list"
      }
      layers                 = []
      vpc_subnet_ids         = []
      vpc_security_group_ids = []
      policies               = [aws_iam_policy.lambda_iam_policy_dynamodb.arn]
      version = {
        dev  = 3 # Autodeploys to latest Lambda version.
        test = 3 # Autodeploys to latest Lambda version.
        prod = 3
      }
    }

    get-places = {
      description = "Fetches places details from DynamoDB."
      environment_variables = {
        "DYNAMODB_TABLE" = "places"
      }
      layers                 = []
      vpc_subnet_ids         = []
      vpc_security_group_ids = []
      policies               = [aws_iam_policy.lambda_iam_policy_dynamodb.arn]
      version = {
        dev  = 3 # Autodeploys to latest Lambda version.
        test = 3 # Autodeploys to latest Lambda version.
        prod = 3
      }
    }

    get-spotify-currently-playing = {
      description = "Fetches currently playing Spotify music from Spotify API."
      environment_variables = {
        "SPOTIFY_API_URL_AUTH_TOKEN"             = "https://accounts.spotify.com/api/token"
        "SPOTIFY_API_URL_CURRENT_SONG"           = "https://api.spotify.com/v1/me/player/currently-playing?market=US"
        "SSM_PARAM_SPOTIFY_CLIENT_ID"            = aws_ssm_parameter.spotify_client_id.name
        "SSM_PARAM_SPOTIFY_CLIENT_REFRESH_TOKEN" = aws_ssm_parameter.spotify_client_refresh_token.name
        "SSM_PARAM_SPOTIFY_CLIENT_SECRET"        = aws_ssm_parameter.spotify_client_secret.name
      }
      layers                 = ["ssm-access", "web-request"]
      vpc_subnet_ids         = var.vpc_private_subnet_ids
      vpc_security_group_ids = [var.vpc_default_security_group_id]
      policies               = [aws_iam_policy.lambda_iam_policy_ssm_params.arn]
      version = {
        dev  = 2
        test = 2
        prod = 2
      }
    }

    get-weather = {
      description = "Fetches current weather from OpenWeatherMap API."
      environment_variables = {
        "OPEN_WEATHER_MAP_API_URL_WEATHER"  = "https://api.openweathermap.org/data/2.5/weather"
        "SSM_PARAM_OPEN_WEATHER_MAP_APP_ID" = aws_ssm_parameter.open_weather_map_app_id.name
      }
      layers                 = ["ssm-access", "web-request"]
      vpc_subnet_ids         = var.vpc_private_subnet_ids
      vpc_security_group_ids = [var.vpc_default_security_group_id]
      policies               = [aws_iam_policy.lambda_iam_policy_ssm_params.arn]
      version = {
        dev  = 3
        test = 3
        prod = 3
      }
    }
  }

  output_type = "zip"
}
