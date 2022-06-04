locals {
  tags = {
    Environment = var.env
    Application = var.project_name
  }
}
