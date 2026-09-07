resource "aws_dynamodb_table" "UserDetails" {
  name           = "UserDetails_${var.ecr_env}"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "emailId"

  attribute {
    name = "emailId"
    type = "S"
  }
}

resource "aws_dynamodb_table_item" "UserDetails" {
  table_name = aws_dynamodb_table.UserDetails.name
  hash_key   = aws_dynamodb_table.UserDetails.hash_key

  # NOTE: seeded with a placeholder test user for initial setup verification.
  item = jsonencode({
    "emailId" = {
      "S" = "testuser@example.com"
    },
    "password" = {
      "S" = ""
    },
    "firstname" = {
      "S" = ""
    },
    "lastname" = {
      "S" = ""
    },
    "role" = {
      "S" = ""
    },
    "registeredDate" = {
      "S" = ""
    },
    "status" = {
      "S" = ""
    }
  })
}
