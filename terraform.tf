terraform {
  backend "s3" {
    bucket         = "terraform-states-552566233886-us-east-1"
    key            = "harryseong.com-tf/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-states"
  }
}
