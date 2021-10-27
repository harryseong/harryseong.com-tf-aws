locals {
  tags = {
    Terraform   = "true"
    Environment = "shared"
  }

  dynamodb_table_configs = {
    places_v2 = {
      create_table   = true
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

      item = {
        "place_id" : {
          "N" : "6"
        },
        "order" : {
          "N" : "6"
        },
        "displayName" : {
          "S" : "Singapore"
        },
        "years" : {
          "M" : {
            "start" : {
              "N" : "2017"
            },
            "end" : {
              "NULL" : true
            }
          }
        },
        "coords" : {
          "M" : {
            "lng" : {
              "N" : "103.851959"
            },
            "lat" : {
              "N" : "1.29027"
            }
          }
        },
        "description" : {
          "S" : "I've visited this Southeast Asian gem of a city-state on five occasions. This diverse, cosmopolitan metropolis is a sight to behold."
        },
        "fullName" : {
          "S" : "Singapore"
        }
      }
    }

    bucket_list_v2 = {
      create_table   = true
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

      item = {
        "item_id" : {
          "N" : "7"
        },
        "completed" : {
          "BOOL" : false
        },
        "priority" : {
          "N" : "9"
        },
        "date_completed" : {
          "S" : ""
        },
        "title" : {
          "S" : "Deploy first iPhone app."
        }
      }
    }
  }
}
