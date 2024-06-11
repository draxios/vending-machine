variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "dynamodb_read_capacity" {
  description = "The number of read units for the DynamoDB table"
  type        = number
  default     = 5
}

variable "dynamodb_write_capacity" {
  description = "The number of write units for the DynamoDB table"
  type        = number
  default     = 5
}

variable "dynamodb_hash_key" {
  description = "The hash key for the DynamoDB table"
  type        = string
}

variable "dynamodb_range_key" {
  description = "The range key for the DynamoDB table (optional)"
  type        = string
  default     = null
}

variable "dynamodb_attribute_definitions" {
  description = "List of attribute definitions for the table"
  type        = list(object({
    name = string
    type = string
  }))
}
