module "lambda_functions" {
  source = "./functions"

  region  = data.aws_region.current.name
  api_url = local.api_url
}
