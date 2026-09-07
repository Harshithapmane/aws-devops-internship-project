###################################
#### FRONTEND
###################################
resource "aws_ecs_cluster" "HCI-AWS-ecs-cluster-frontend" {
  name = "HCI-AWS-${var.environment}-ecs-cluster-frontend"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "task_definition_frontend" {
  family                 = "HCI-AWS_${var.environment}_TASK_DEF_FRONTEND"
  container_definitions  = file("frontend_taskdef.json")
  cpu                    = 1024
  memory                 = 3072
  network_mode           = "host"
  execution_role_arn     = var.execution_role_arn
}

resource "aws_ecs_service" "service1" {
  name                                = "frontend-service"
  cluster                             = aws_ecs_cluster.HCI-AWS-ecs-cluster-frontend.id
  task_definition                     = aws_ecs_task_definition.task_definition_frontend.arn
  desired_count                       = 1
  scheduling_strategy                 = "REPLICA"
  deployment_maximum_percent          = 200
  deployment_minimum_healthy_percent  = 0
}

###################################
#### BACKEND
###################################
resource "aws_ecs_cluster" "HCI-AWS-ecs-cluster-Backend" {
  name = "HCI-AWS-${var.environment}-ecs-cluster-Backend"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "task_definition_backend" {
  family                 = "HCI-AWS_${var.environment}_TASK_DEF_BACKEND"
  container_definitions  = file("backend_taskdef.json")
  cpu                    = 1024
  memory                 = 3072
  network_mode           = "host"
  execution_role_arn     = var.execution_role_arn
}

resource "aws_ecs_service" "service2" {
  name                                = "backend-service"
  cluster                             = aws_ecs_cluster.HCI-AWS-ecs-cluster-Backend.id
  task_definition                     = aws_ecs_task_definition.task_definition_backend.arn
  desired_count                       = 1
  scheduling_strategy                 = "REPLICA"
  deployment_maximum_percent          = 200
  deployment_minimum_healthy_percent  = 0
}
