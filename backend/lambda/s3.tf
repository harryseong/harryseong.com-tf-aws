module "lambda_s3_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  create_bucket = true
  force_destroy = true
  bucket        = "lambda-${local.api_url}-${data.aws_region.current.name}"
  acl           = "private"
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
}

resource "aws_s3_bucket_object" "lambda_layer_s3_object" {
  for_each = toset(keys(local.layer-configs))

  bucket      = module.lambda_s3_bucket.s3_bucket_id
  key         = "layers/${each.key}.${local.output_type}"
  source      = data.archive_file.lambda_layer[each.key].output_path
  source_hash = filemd5(data.archive_file.lambda_layer[each.key].output_path)
  etag        = filemd5(data.archive_file.lambda_layer[each.key].output_path)
  tags        = local.tags
}

resource "aws_s3_bucket_object" "lambda_function_s3_object" {
  for_each = toset(keys(local.function-configs))

  bucket      = module.lambda_s3_bucket.s3_bucket_id
  key         = "functions/${each.key}.${local.output_type}"
  source      = data.archive_file.lambda_function[each.key].output_path
  source_hash = filemd5(data.archive_file.lambda_function[each.key].output_path)
  etag        = filemd5(data.archive_file.lambda_function[each.key].output_path)
  tags        = local.tags
}
