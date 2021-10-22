locals {
  tags = {
    Terraform   = "true"
    Environment = "api"
  }

  functions = [
    "get-bucket-list-items",
    "get-places",
    "get-spotify-currently-playing",
    "get-weather"
  ]
  output_type = "zip"
}
