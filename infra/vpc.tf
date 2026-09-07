resource "aws_vpc" "HCI-AWS-VPC" {
  cidr_block = "10.0.16.0/20"
  tags = {
    Name        = "HCI-AWS-${var.environment}-VPC"
    Application = "HCI-AWS-${var.environment}"
  }
}
