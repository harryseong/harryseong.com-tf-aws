module "codepipeline_artifacts_s3_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  create_bucket = true
  force_destroy = true
  bucket        = "codepipeline-artifacts-${var.webapp_url}-${data.aws_region.current.name}"
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
