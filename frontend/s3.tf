module "webapp_s3_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  create_bucket = true
  force_destroy = true
  bucket        = local.webapp_url
  tags          = local.tags

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  website = {
    index_document = "index.html"
    error_document = "index.html"
    routing_rules  = null
  }
}

resource "aws_s3_bucket_policy" "webapp_s3_bucket_policy" {
  bucket = module.webapp_s3_bucket.s3_bucket_id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "s3-bucket-policy-${local.webapp_url}"
    Statement = [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource" : "${module.webapp_s3_bucket.s3_bucket_arn}/*"
      }
    ]
  })
}
