module "lambda" {
  source   = "./lambda"
  env_list = var.env_list

  project_name = var.project_name
  domain_name  = var.domain_name
}
