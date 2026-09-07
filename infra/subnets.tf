resource "aws_subnet" "HCI-AWS-public-1" {
  vpc_id            = aws_vpc.HCI-AWS-VPC.id
  cidr_block        = "10.0.17.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name        = "HCI-AWS-${var.environment}-public-1"
    Application = "HCI-AWS-${var.environment}"
  }
}

resource "aws_subnet" "HCI-AWS-public-2" {
  vpc_id            = aws_vpc.HCI-AWS-VPC.id
  cidr_block        = "10.0.18.0/24"
  availability_zone = "${var.region}b"
  tags = {
    Name        = "HCI-AWS-${var.environment}-public-2"
    Application = "HCI-AWS-${var.environment}"
  }
}

resource "aws_subnet" "HCI-AWS-private-1" {
  vpc_id            = aws_vpc.HCI-AWS-VPC.id
  cidr_block        = "10.0.19.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name        = "HCI-AWS-${var.environment}-private-1"
    Application = "HCI-AWS-${var.environment}"
  }
}

resource "aws_subnet" "HCI-AWS-private-2" {
  vpc_id            = aws_vpc.HCI-AWS-VPC.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "${var.region}b"
  tags = {
    Name        = "HCI-AWS-${var.environment}-private-2"
    Application = "HCI-AWS-${var.environment}"
  }
}
