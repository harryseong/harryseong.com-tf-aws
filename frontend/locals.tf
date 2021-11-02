locals {
  tags = {
    Terraform   = "true"
    Environment = var.env
    Application = var.project_name
  }

  webapp_prefix = var.env == "prod" ? "" : var.env
  webapp_url    = var.env == "prod" ? var.domain_name : "${local.webapp_prefix}.${var.domain_name}"
}
