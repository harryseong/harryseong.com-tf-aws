module "api_gateway" {
  source = "./api_gateway"
  env    = "api"

  project_name          = var.project_name
  domain_name           = var.domain_name
  public_hosted_zone_id = var.public_hosted_zone_id
  lambda_functions      = module.lambda.functions
}

module "lambda" {
  source = "./lambda"
  env    = "api"

  project_name                  = var.project_name
  domain_name                   = var.domain_name
  vpc_default_security_group_id = var.vpc_default_security_group_id
  vpc_private_subnet_ids        = var.vpc_private_subnet_ids
}

module "dynamodb" {
  source = "./dynamodb"
  env    = "shared"
}

module "cognito" {
  source = "./cognito"
  env    = "shared"

  project_name          = var.project_name
  domain_name           = var.domain_name
  public_hosted_zone_id = var.public_hosted_zone_id
}
