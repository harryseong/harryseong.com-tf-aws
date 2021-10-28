locals {
  tags = {
    Terraform   = "true"
    Environment = var.env
  }

  auth_prefix = "auth"
  auth_url    = "${local.auth_prefix}.${var.domain_name}"
}
