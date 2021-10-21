locals {
  tags = {
    Terraform   = "true"
    Environment = var.env
  }

  webapp_url = format("%s.%s", (var.env == "prod" ? "www" : var.env), var.domain_name)
}
