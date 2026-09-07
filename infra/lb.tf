resource "aws_lb" "HCI-AWS-ALB" {
  name                = "HCI-AWS-${var.environment}-ALB"
  internal            = false
  ip_address_type     = "ipv4"
  load_balancer_type  = "application"
  security_groups     = [aws_security_group.HCI-AWS-alb-SG.id]
  subnets             = [aws_subnet.HCI-AWS-public-1.id, aws_subnet.HCI-AWS-public-2.id]
}

resource "aws_lb_listener" "HCI-AWS-listener" {
  load_balancer_arn = aws_lb.HCI-AWS-ALB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/html"
      message_body = file("rule.html")
      status_code  = "503"
    }
  }
}

resource "aws_lb_listener_rule" "backend-rule" {
  listener_arn = aws_lb_listener.HCI-AWS-listener.arn
  priority     = 200

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.HCI-AWS-TG-backend.arn
  }

  condition {
    path_pattern {
      values = ["/service/*"]
    }
  }
}

resource "aws_lb_listener_rule" "frontend-rule" {
  listener_arn = aws_lb_listener.HCI-AWS-listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.HCI-AWS-TG-frontend.arn
  }

  condition {
    path_pattern {
      values = ["/jiraportal/*"]
    }
  }
}

resource "aws_lb_target_group" "HCI-AWS-TG-frontend" {
  name        = "HCI-AWS-${var.environment}-TG-frontend"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.HCI-AWS-VPC.id

  health_check {
    interval             = 30
    path                 = "/jiraportal/*"
    protocol             = "HTTP"
    timeout              = 5
    healthy_threshold    = 5
    unhealthy_threshold  = 5
    port                 = 80
  }
}

resource "aws_lb_target_group" "HCI-AWS-TG-backend" {
  name        = "HCI-AWS-${var.environment}-TG-backend"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.HCI-AWS-VPC.id

  health_check {
    interval             = 30
    path                 = "/service/api/epic/"
    protocol             = "HTTP"
    timeout              = 5
    healthy_threshold    = 5
    unhealthy_threshold  = 5
    port                 = 80
  }
}
