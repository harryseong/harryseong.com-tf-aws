module "lambda" {
  source   = "./lambda"
  env_list = var.env_list

  project_name = var.project_name
  domain_name  = var.domain_name
}

module "api_gateway" {
  source = "./api_gateway"

  project_name          = var.project_name
  domain_name           = var.domain_name
  public_hosted_zone_id = var.public_hosted_zone_id
}
