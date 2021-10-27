module "dynamodb_table" {
  for_each     = local.dynamodb_table_configs
  source       = "terraform-aws-modules/dynamodb-table/aws"
  version      = "1.1.0"
  create_table = each.value.create_table

  name           = each.key
  hash_key       = each.value.hash_key  # partition key
  range_key      = each.value.range_key # sort key
  billing_mode   = each.value.billing_mode
  read_capacity  = each.value.read_capacity
  write_capacity = each.value.write_capacity
  tags           = local.tags

  attributes = each.value.attributes
}
