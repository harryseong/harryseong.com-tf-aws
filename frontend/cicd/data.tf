data "aws_region" "current" {}

data "aws_kms_alias" "s3kmskey" {
  name = "alias/aws/s3"
}
