module "api_gateway" {
  source = "./api_gateway"

  project_name          = var.project_name
  domain_name           = var.domain_name
  public_hosted_zone_id = var.public_hosted_zone_id
}

module "lambda" {
  source   = "./lambda"
  env_list = var.env_list

  project_name                  = var.project_name
  domain_name                   = var.domain_name
  vpc_default_security_group_id = var.vpc_default_security_group_id
  vpc_private_subnet_ids        = var.vpc_private_subnet_ids
}

module "dynamodb" {
  source = "./dynamodb"
}
