resource "aws_internet_gateway" "HCI-AWS-internetgateway" {
  vpc_id = aws_vpc.HCI-AWS-VPC.id
  tags = {
    Name        = "HCI-AWS-${var.environment}-internetgateway"
    Application = "HCI-AWS-${var.environment}"
  }
}
