module "lambda_functions_s3_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  create_bucket = true
  force_destroy = true
  bucket        = "lambda-functions-${var.api_url}-${var.region}"
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

data "archive_file" "lambda_function" {
  for_each = toset(local.functions)

  type        = local.output_type
  source_dir  = "${path.module}/code/${each.key}"
  output_path = "${path.module}/code/${each.key}.${local.output_type}"
}

resource "aws_s3_bucket_object" "lambda_function_s3_object" {
  for_each = toset(local.functions)

  bucket = module.lambda_functions_s3_bucket.s3_bucket_id
  key    = "${each.key}.${local.output_type}"
  source = data.archive_file.lambda_function[each.key].output_path
  etag   = filemd5(data.archive_file.lambda_function[each.key].output_path)
}
