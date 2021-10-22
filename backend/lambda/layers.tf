module "lambda_layers" {
  source = "./layers"

  region  = data.aws_region.current.name
  api_url = local.api_url
}
