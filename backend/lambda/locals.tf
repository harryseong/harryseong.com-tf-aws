locals {
  tags = {
    Terraform   = "true"
    Environment = var.env
    Application = var.project_name
  }

  api_prefix = "api"
  api_url    = format("%s.%s", local.api_prefix, var.domain_name)

  layer_configs = {
    ssm-access  = { description = "For fetching SSM parameter store values." }
    web-request = { description = "For making external API calls." }
    sns-access  = { description = "For publishing messages to SNS topic." }
  }

  function_configs = {
    basic-auth = {
      description = "Performs basic auth for test Cloudfront."
      environment_variables = {
        "SSM_PARAM_BASIC_AUTH_USERNAME" = aws_ssm_parameter.basic_auth_username.name
        "SSM_PARAM_BASIC_AUTH_PASSWORD" = aws_ssm_parameter.basic_auth_password.name
      }
      layers                 = ["ssm-access"]
      vpc_subnet_ids         = []
      vpc_security_group_ids = []
      lambda_at_edge         = true
      policies               = [aws_iam_policy.lambda_iam_policy_ssm_params.arn]
      version = {
        dev  = 1 # Autodeploys to latest Lambda version.
        test = 1 # Autodeploys to latest Lambda version.
        prod = 1
      }
    }

    get-bucket-list-items = {
      description = "Fetches bucket list items from DynamoDB."
      environment_variables = {
        "DYNAMODB_TABLE" = "bucket_list"
      }
      layers                 = []
      vpc_subnet_ids         = []
      vpc_security_group_ids = []
      lambda_at_edge         = false
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
      lambda_at_edge         = false
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
      lambda_at_edge         = false
      policies               = [aws_iam_policy.lambda_iam_policy_ssm_params.arn]
      version = {
        dev  = 2 # Autodeploys to latest Lambda version.
        test = 2 # Autodeploys to latest Lambda version.
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
      lambda_at_edge         = false
      policies               = [aws_iam_policy.lambda_iam_policy_ssm_params.arn]
      version = {
        dev  = 3 # Autodeploys to latest Lambda version.
        test = 3 # Autodeploys to latest Lambda version.
        prod = 3
      }
    }

    daily-weather-updates = {
      description = "Fetches current weather from OpenWeatherMap API to send daily."
      environment_variables = {
        "OPEN_WEATHER_MAP_API_URL_WEATHER"  = "https://api.openweathermap.org/data/2.5/weather"
        "SSM_PARAM_OPEN_WEATHER_MAP_APP_ID" = aws_ssm_parameter.open_weather_map_app_id.name
      }
      layers                 = ["ssm-access", "web-request", "sns-access"]
      vpc_subnet_ids         = var.vpc_private_subnet_ids
      vpc_security_group_ids = [var.vpc_default_security_group_id]
      lambda_at_edge         = false
      policies               = [aws_iam_policy.lambda_iam_policy_ssm_params.arn, aws_iam_policy.lambda_iam_policy_sns.arn]
      version = {
        dev  = 9 # Autodeploys to latest Lambda version.
        test = 9 # Autodeploys to latest Lambda version.
        prod = 9
      }
    }
  }

  output_type = "zip"
}
