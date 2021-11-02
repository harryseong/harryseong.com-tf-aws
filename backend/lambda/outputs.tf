output "functions" {
  value = {
    "get-bucket-list-items"         = module.lambda_function["get-bucket-list-items"].lambda_function_arn
    "get-places"                    = module.lambda_function["get-places"].lambda_function_arn
    "get-spotify-currently-playing" = module.lambda_function["get-spotify-currently-playing"].lambda_function_arn
    "get-weather"                   = module.lambda_function["get-weather"].lambda_function_arn
  }
}
