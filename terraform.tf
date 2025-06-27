terraform {
  required_version = ">= 0.12.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0"
    }
  }

  backend "s3" {
    bucket       = "terraform-states-552566233886-us-east-1"
    key          = "harryseong.com-tf/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
