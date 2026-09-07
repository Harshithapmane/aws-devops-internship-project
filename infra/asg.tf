resource "aws_autoscaling_group" "asg" {
  desired_capacity          = 1
  max_size                  = 2
  min_size                  = 1
  vpc_zone_identifier       = [aws_subnet.HCI-AWS-private-1.id]
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  name                      = "HCI-AWS-${var.environment}-FRONTEND-asg"

  launch_template {
    id      = aws_launch_template.template_frontend.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "HCI-AWS-${var.environment}-FRONTEND"
    propagate_at_launch = true
  }
}

resource "aws_launch_template" "template_frontend" {
  name                    = "HCI-AWS-${var.environment}-launch-template-frontend"
  image_id                = "ami-0bf5ac026c9b5eb88"
  instance_type           = "t2.medium"
  vpc_security_group_ids  = [aws_security_group.HCI-AWS-ec2-SG.id]
  key_name                = "<your-keypair-name>"

  iam_instance_profile {
    name = "EC2-Container-Instance-Role"
  }

  block_device_mappings {
    device_name = "/dev/xvdf"
    ebs {
      volume_size            = 100
      delete_on_termination  = true
      volume_type            = "gp3"
      iops                   = 3000
      throughput             = 125
    }
  }

  monitoring {
    enabled = true
  }

  user_data = filebase64("user_data_frontend.sh")
}

#############
### BACKEND
#############

resource "aws_autoscaling_group" "asg2" {
  desired_capacity          = 1
  max_size                  = 2
  min_size                  = 1
  vpc_zone_identifier       = [aws_subnet.HCI-AWS-private-1.id]
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  name                      = "HCI-AWS-${var.environment}-BACKEND-asg"

  launch_template {
    id      = aws_launch_template.template_backend.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "HCI-AWS-${var.environment}-BACKEND"
    propagate_at_launch = true
  }
}

resource "aws_launch_template" "template_backend" {
  name                    = "HCI-AWS-${var.environment}-launch-template-backend"
  image_id                = "ami-0bf5ac026c9b5eb88"
  instance_type           = "t2.medium"
  vpc_security_group_ids  = [aws_security_group.HCI-AWS-ec2-SG.id]
  key_name                = "<your-keypair-name>"

  iam_instance_profile {
    name = "EC2-Container-Instance-Role"
  }

  block_device_mappings {
    device_name = "/dev/xvdf"
    ebs {
      volume_size            = 100
      delete_on_termination  = true
      volume_type            = "gp3"
      iops                   = 3000
      throughput             = 125
    }
  }

  monitoring {
    enabled = true
  }

  user_data = filebase64("user_data_backend.sh")
}

resource "aws_autoscaling_schedule" "HCI-AWS-FRONTEND-NOTIFY-UP" {
  scheduled_action_name   = "HCI-AWS-FRONTEND-SCHEDULE-UP"
  min_size                = 1
  max_size                = 2
  desired_capacity        = 1
  time_zone               = "Asia/Kolkata"
  recurrence              = "00 09 * * 1-5"
  autoscaling_group_name  = aws_autoscaling_group.asg.name
}

resource "aws_autoscaling_schedule" "HCI-AWS-FRONTEND-NOTIFY-DOWN" {
  scheduled_action_name   = "HCI-AWS-FRONTEND-SCHEDULE_DOWN"
  min_size                = 0
  max_size                = 0
  desired_capacity        = 0
  time_zone               = "Asia/Kolkata"
  recurrence              = "00 21 * * 1-5"
  autoscaling_group_name  = aws_autoscaling_group.asg.name
}

resource "aws_autoscaling_schedule" "HCI-AWS-BACKEND-NOTIFY-UP" {
  scheduled_action_name   = "HCI-AWS-BACKEND-SCHEDULE-UP"
  min_size                = 1
  max_size                = 2
  desired_capacity        = 1
  time_zone               = "Asia/Kolkata"
  recurrence              = "00 09 * * 1-5"
  autoscaling_group_name  = aws_autoscaling_group.asg2.name
}

resource "aws_autoscaling_schedule" "HCI-AWS-BACKEND-NOTIFY-DOWN" {
  scheduled_action_name   = "HCI-AWS-BACKEND-SCHEDULE-DOWN"
  min_size                = 0
  max_size                = 0
  desired_capacity        = 0
  time_zone               = "Asia/Kolkata"
  recurrence              = "00 21 * * 1-5"
  autoscaling_group_name  = aws_autoscaling_group.asg2.name
}
