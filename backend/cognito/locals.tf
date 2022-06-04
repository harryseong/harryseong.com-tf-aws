locals {
  tags = {
    Environment = var.env
    Application = var.project_name
  }

  auth_prefix = "auth"
  auth_url    = "${local.auth_prefix}.${var.domain_name}"
}
