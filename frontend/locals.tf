locals {
  tags = {
    Terraform   = "true"
    Environment = var.env
  }

  webapp_prefix = var.env == "prod" ? "" : var.env
  webapp_url    = var.env == "prod" ? var.domain_name : format("%s.%s", local.webapp_prefix, var.domain_name)
}
