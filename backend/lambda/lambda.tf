module "lambda_layer" {
  for_each     = toset(keys(local.layer-configs))
  source       = "terraform-aws-modules/lambda/aws"
  create_layer = true

  layer_name          = each.key
  description         = local.layer-configs[each.key].description
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
  for_each        = toset(keys(local.function-configs))
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
  description            = local.function-configs[each.key].description
  handler                = "index.handler"
  runtime                = "nodejs14.x"
  environment_variables  = local.function-configs[each.key].environment_variables
  layers                 = [for layer_name in local.function-configs[each.key].layers : module.lambda_layer[layer_name].lambda_layer_arn]
  vpc_subnet_ids         = local.function-configs[each.key].vpc_subnet_ids
  vpc_security_group_ids = local.function-configs[each.key].vpc_security_group_ids

  # Lambda function permissions:
  create_role           = true
  attach_network_policy = true
  attach_policies       = true
  policies              = local.function-configs[each.key].policies
  number_of_policies    = length(local.function-configs[each.key].policies)
  role_tags             = local.tags

  tags = local.tags
}

module "lambda_function_alias_dev" {
  for_each = toset(keys(local.function-configs))
  source   = "terraform-aws-modules/lambda/aws//modules/alias"
  version  = "2.23.0"
  create   = true

  name          = "dev"
  description   = "Lambda function alias for dev testing."
  refresh_alias = true
  function_name = module.lambda_function[each.key].lambda_function_name
}

module "lambda_function_alias_test" {
  for_each = toset(keys(local.function-configs))
  source   = "terraform-aws-modules/lambda/aws//modules/alias"
  version  = "2.23.0"
  create   = true

  name          = "test"
  description   = "Lambda function alias for test environment."
  refresh_alias = true
  function_name = module.lambda_function[each.key].lambda_function_name
  # function_version = local.function-configs[each.key].version.test
}

module "lambda_function_alias_prod" {
  for_each = toset(keys(local.function-configs))
  source   = "terraform-aws-modules/lambda/aws//modules/alias"
  version  = "2.23.0"
  create   = true

  name             = "prod"
  description      = "Lambda function alias for prod environment."
  refresh_alias    = false
  function_name    = module.lambda_function[each.key].lambda_function_name
  function_version = local.function-configs[each.key].version.prod
}
