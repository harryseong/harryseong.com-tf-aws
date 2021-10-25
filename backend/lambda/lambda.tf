module "lambda_layer" {
  for_each     = local.layers
  source       = "terraform-aws-modules/lambda/aws"
  create_layer = true

  layer_name          = each.key
  description         = each.value
  compatible_runtimes = ["nodejs14.x"]

  create_package = false
  s3_existing_package = {
    bucket = module.lambda_s3_bucket.s3_bucket_id
    key    = aws_s3_bucket_object.lambda_layer_s3_object[each.key].id
  }
  tags = local.tags
}

module "lambda_function" {
  for_each        = local.functions
  source          = "terraform-aws-modules/lambda/aws"
  create_function = true

  function_name = each.key
  description   = each.value
  handler       = "index.lambda_handler"
  runtime       = "nodejs14.x"

  create_package = false
  s3_existing_package = {
    bucket = module.lambda_s3_bucket.s3_bucket_id
    key    = aws_s3_bucket_object.lambda_function_s3_object[each.key].id
  }
  tags = local.tags
}
