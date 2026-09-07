resource "aws_security_group" "HCI-AWS-alb-SG" {
  name        = "HCI-AWS-${var.environment}-alb-SG"
  description = "Allow alb inbound traffic"
  vpc_id      = aws_vpc.HCI-AWS-VPC.id
  tags = {
    Name        = "HCI-AWS-${var.environment}-alb-SG"
    Application = "HCI-AWS-${var.environment}"
  }
}

resource "aws_security_group" "HCI-AWS-ec2-SG" {
  name        = "HCI-AWS-${var.environment}-ec2-SG"
  description = "Allow ec2 inbound traffic"
  vpc_id      = aws_vpc.HCI-AWS-VPC.id
  tags = {
    Name        = "HCI-AWS-${var.environment}-ec2-SG"
    Application = "HCI-AWS-${var.environment}"
  }
}

resource "aws_security_group_rule" "HCI-AWS-ec2-rule" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "TCP"
  security_group_id        = aws_security_group.HCI-AWS-ec2-SG.id
  source_security_group_id = aws_security_group.HCI-AWS-alb-SG.id
  description              = "input from ALB"
}

resource "aws_security_group_rule" "HCI-AWS-alb-rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.HCI-AWS-alb-SG.id
  description       = "ALB ingress"
}

resource "aws_security_group_rule" "HCI-AWS-ec2-1-rule" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.HCI-AWS-ec2-SG.id
  description       = "from SSM agent"
}

resource "aws_security_group_rule" "HCI-AWS-ec2-2-rule" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.HCI-AWS-ec2-SG.id
  description       = "from SSM agent"
}

resource "aws_security_group_rule" "HCI-AWS-ec2-3-rule" {
  type              = "egress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.HCI-AWS-ec2-SG.id
  description       = "from SSM agent"
}

resource "aws_security_group_rule" "HCI-AWS-alb-1-rule" {
  type                     = "egress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "TCP"
  security_group_id        = aws_security_group.HCI-AWS-alb-SG.id
  source_security_group_id = aws_security_group.HCI-AWS-ec2-SG.id
  description              = "ECS"
}
