data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "archive_file" "lambda_layer" {
  for_each = toset(keys(local.layer_configs))

  type        = local.output_type
  source_dir  = "${path.module}/src/layers/${each.key}"
  output_path = "${path.module}/src/layers/${each.key}.${local.output_type}"
}

data "archive_file" "lambda_function" {
  for_each = toset(keys(local.function_configs))

  type        = local.output_type
  source_dir  = "${path.module}/src/functions/${each.key}"
  output_path = "${path.module}/src/functions/${each.key}.${local.output_type}"
}
