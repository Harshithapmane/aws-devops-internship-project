resource "aws_eip" "HCI-AWS-eip" {
  tags = {
    Name        = "HCI-AWS-${var.environment}-eip"
    Application = "HCI-AWS-${var.environment}"
  }
}

resource "aws_nat_gateway" "HCI-AWS-natgateway" {
  allocation_id = aws_eip.HCI-AWS-eip.id
  subnet_id     = aws_subnet.HCI-AWS-public-1.id
  tags = {
    Name        = "HCI-AWS-${var.environment}-natgateway"
    Application = "HCI-AWS-${var.environment}"
  }
}
