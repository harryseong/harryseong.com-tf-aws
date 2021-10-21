module "codepipeline_artifacts_s3_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  create_bucket = true
  bucket        = "codepipeline-${data.aws_region.current.name}-${var.webapp_url}"
  acl           = "private"
  tags          = local.tags

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }
}
