resource "aws_dynamodb_table" "PlannedStoryPoints" {
  name           = "PlannedStoryPoints_${var.ecr_env}"
  read_capacity  = 10
  write_capacity = 10
  hash_key       = "id"

  attribute {
    name = "id"
    type = "N"
  }
}

resource "aws_dynamodb_table_item" "PlannedStoryPoints" {
  table_name = aws_dynamodb_table.PlannedStoryPoints.name
  hash_key   = aws_dynamodb_table.PlannedStoryPoints.hash_key

  item = jsonencode({
    "id" = {
      "N" = "0"
    },
    "capturedDate" = {
      "S" = ""
    },
    "sprintDetails" = {
      "M" = {
        "activatedDate" = {
          "S" = ""
        },
        "completeDate" = {
          "S" = ""
        },
        "endDate" = {
          "S" = ""
        },
        "jiraId" = {
          "N" = "0"
        },
        "name" = {
          "S" = ""
        },
        "startDate" = {
          "S" = ""
        },
        "state" = {
          "S" = ""
        }
      }
    },
    "storyPoints" = {
      "N" = "0"
    }
  })
}
