resource "aws_route_table" "HCI-AWS-public1-route-table" {
  vpc_id = aws_vpc.HCI-AWS-VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.HCI-AWS-internetgateway.id
  }
  tags = {
    Name        = "HCI-AWS-${var.environment}-public1-route-table"
    Application = "HCI-AWS-${var.environment}"
  }
}

resource "aws_route_table" "HCI-AWS-public2-route-table" {
  vpc_id = aws_vpc.HCI-AWS-VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.HCI-AWS-internetgateway.id
  }
  tags = {
    Name        = "HCI-AWS-${var.environment}-public2-route-table"
    Application = "HCI-AWS-${var.environment}"
  }
}

resource "aws_route_table" "HCI-AWS-private1-route-table" {
  vpc_id = aws_vpc.HCI-AWS-VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.HCI-AWS-natgateway.id
  }
  tags = {
    Name        = "HCI-AWS-${var.environment}-private1-route-table"
    Application = "HCI-AWS-${var.environment}"
  }
}

resource "aws_route_table" "HCI-AWS-private2-route-table" {
  vpc_id = aws_vpc.HCI-AWS-VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.HCI-AWS-natgateway.id
  }
  tags = {
    Name        = "HCI-AWS-${var.environment}-private2-route-table"
    Application = "HCI-AWS-${var.environment}"
  }
}
