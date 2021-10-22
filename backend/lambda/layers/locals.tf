locals {
  tags = {
    Terraform   = "true"
    Environment = "api"
  }

  layers = [
    "ssm-access",
    "web-request"
  ]
  output_type = "zip"
}
