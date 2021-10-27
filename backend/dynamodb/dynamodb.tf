# module "dynamodb_table" {
#   for_each     = local.dynamodb_table_configs
#   source       = "terraform-aws-modules/dynamodb-table/aws"
#   version      = "1.1.0"
#   create_table = each.value.create_table

#   name           = each.key
#   hash_key       = each.value.hash_key  # partition key
#   range_key      = each.value.range_key # sort key
#   billing_mode   = each.value.billing_mode
#   read_capacity  = each.value.read_capacity
#   write_capacity = each.value.write_capacity
#   tags           = local.tags

#   attributes = each.value.attributes
# }

# resource "aws_dynamodb_table_item" "places_seed_data" {
#   table_name = module.dynamodb_table["places_v2"].dynamodb_table_id
#   hash_key   = local.dynamodb_table_configs.places_v2.hash_key
#   range_key  = local.dynamodb_table_configs.places_v2.range_key

#   item = jsonencode(local.dynamodb_table_configs.places_v2.item)
# }

# resource "aws_dynamodb_table_item" "bucket_list_seed_data" {
#   table_name = module.dynamodb_table["bucket_list_v2"].dynamodb_table_id
#   hash_key   = local.dynamodb_table_configs.bucket_list_v2.hash_key
#   range_key  = local.dynamodb_table_configs.bucket_list_v2.range_key

#   item = jsonencode(local.dynamodb_table_configs.bucket_list_v2.item)
# }

