data "aws_region" "current" {}

data "archive_file" "lambda_layer" {
  for_each = local.layers

  type        = local.output_type
  source_dir  = "${path.module}/src/layers/${each.key}"
  output_path = "${path.module}/src/layers/${each.key}.${local.output_type}"
}

data "archive_file" "lambda_function" {
  for_each = local.functions

  type        = local.output_type
  source_dir  = "${path.module}/src/functions/${each.key}"
  output_path = "${path.module}/src/functions/${each.key}.${local.output_type}"
}
