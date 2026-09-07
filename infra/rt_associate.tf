resource "aws_route_table_association" "HCI-AWS-private-1-association" {
  subnet_id      = aws_subnet.HCI-AWS-private-1.id
  route_table_id = aws_route_table.HCI-AWS-private1-route-table.id
}

resource "aws_route_table_association" "HCI-AWS-private-2-association" {
  subnet_id      = aws_subnet.HCI-AWS-private-2.id
  route_table_id = aws_route_table.HCI-AWS-private2-route-table.id
}

resource "aws_route_table_association" "HCI-AWS-public-1-association" {
  subnet_id      = aws_subnet.HCI-AWS-public-1.id
  route_table_id = aws_route_table.HCI-AWS-public1-route-table.id
}

resource "aws_route_table_association" "HCI-AWS-public-2-association" {
  subnet_id      = aws_subnet.HCI-AWS-public-2.id
  route_table_id = aws_route_table.HCI-AWS-public2-route-table.id
}
