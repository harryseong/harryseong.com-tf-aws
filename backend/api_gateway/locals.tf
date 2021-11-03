locals {
  tags = {
    Terraform   = "true"
    Environment = var.env
    Application = var.project_name
  }

  api_prefix = "api"
  api_url    = format("%s.%s", local.api_prefix, var.domain_name)

  api_gateway_stages = ["dev", "test", "prod"]
}
