locals {
  tags = {
    Terraform   = "true"
    Environment = var.env
  }

  webapp_prefix = var.env == "prod" ? "www" : var.env
  webapp_url    = format("%s.%s", local.webapp_prefix, var.domain_name)
}
