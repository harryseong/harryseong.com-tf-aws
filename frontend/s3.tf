module "s3_bucket_angular_test" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  create_bucket = true
  force_destroy = true
  bucket        = "test.harryseong.com"
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

resource "aws_s3_bucket_policy" "s3_bucket_policy_webapp" {
  bucket = module.s3_bucket_angular_test.s3_bucket_id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "s3-bucket-policy-test.harryseong.com"
    Statement = [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : module.cloudfront.cloudfront_origin_access_identity_iam_arns[0]
        },
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::test.harryseong.com/*"
      }
    ]
  })
}
