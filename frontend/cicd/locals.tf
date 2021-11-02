locals {
  tags = {
    Terraform   = "true"
    Environment = var.env
    Application = var.project_name
  }
}
