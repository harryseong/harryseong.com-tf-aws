module "lambda_layer" {
  for_each     = toset(local.layers)
  source       = "terraform-aws-modules/lambda/aws"
  create_layer = true

  layer_name          = each.key
  description         = local.layers-configs[each.key].description
  compatible_runtimes = ["nodejs14.x"]

  create_package = false
  s3_existing_package = {
    bucket     = module.lambda_s3_bucket.s3_bucket_id
    key        = aws_s3_bucket_object.lambda_layer_s3_object[each.key].id
    version_id = aws_s3_bucket_object.lambda_layer_s3_object[each.key].version_id
  }
  tags = local.tags
}

module "lambda_function" {
  for_each        = toset(local.functions)
  source          = "terraform-aws-modules/lambda/aws"
  create_function = true
  publish         = true

  create_package = false
  s3_existing_package = {
    bucket     = module.lambda_s3_bucket.s3_bucket_id
    key        = aws_s3_bucket_object.lambda_function_s3_object[each.key].id
    version_id = aws_s3_bucket_object.lambda_function_s3_object[each.key].version_id
  }

  # Lambda function configs:
  function_name          = each.key
  description            = local.functions-configs[each.key].description
  handler                = "index.handler"
  runtime                = "nodejs14.x"
  environment_variables  = local.functions-configs[each.key].environment_variables
  layers                 = [for layer_name in local.functions-configs[each.key].layers : module.lambda_layer[layer_name].lambda_layer_arn]
  vpc_subnet_ids         = local.functions-configs[each.key].vpc_subnet_ids
  vpc_security_group_ids = local.functions-configs[each.key].vpc_security_group_ids

  # Lambda function permissions:
  create_role           = true
  attach_network_policy = true
  attach_policies       = true
  policies              = local.functions-configs[each.key].policies
  number_of_policies    = length(local.functions-configs[each.key].policies)

  tags = local.tags
}
