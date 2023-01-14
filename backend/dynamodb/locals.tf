locals {
  tags = {
    Environment = var.env
    Application = var.project_name
  }

  dynamodb_table_configs = {
    places = {
      create_table   = false
      hash_key       = "place_id"
      range_key      = "order"
      billing_mode   = "PROVISIONED"
      read_capacity  = 5
      write_capacity = 1
      attributes = [
        {
          name = "place_id"
          type = "N"
        },
        {
          name = "order"
          type = "N"
        }
      ]
    }

    bucket_list = {
      create_table   = false
      hash_key       = "item_id"
      range_key      = "priority"
      billing_mode   = "PROVISIONED"
      read_capacity  = 5
      write_capacity = 1
      attributes = [
        {
          name = "item_id"
          type = "N"
        },
        {
          name = "priority"
          type = "N"
        }
      ]
    }

    recipes = {
      create_table   = false
      hash_key       = "item_id"
      range_key      = "priority"
      billing_mode   = "PROVISIONED"
      read_capacity  = 5
      write_capacity = 1
      attributes = [
        {
          name = "item_id"
          type = "N"
        },
        {
          name = "priority"
          type = "N"
        }
      ]
    }
  }
}
