module "dynamodb_table" {
  source  = "tfe.csa.stoker.com/stoker-iac/mod-dynamodb-table/aws"
  version = ">=1.0.0,<2.0.0"

  name             = var.dynamodb_table_name
  read_capacity    = var.dynamodb_read_capacity
  write_capacity   = var.dynamodb_write_capacity
  hash_key         = var.dynamodb_hash_key
  range_key        = var.dynamodb_range_key
  attribute_definitions = var.dynamodb_attribute_definitions

  tags = {
    Name = var.dynamodb_table_name
    Environment = "dev"  # or use a variable to define environment
  }
}
