dynamodb_table_name = "example-table"
dynamodb_read_capacity = 5
dynamodb_write_capacity = 5
dynamodb_hash_key = "id"
dynamodb_range_key = "timestamp"

dynamodb_attribute_definitions = [
  {
    name = "id"
    type = "S"
  },
  {
    name = "timestamp"
    type = "N"
  }
]
