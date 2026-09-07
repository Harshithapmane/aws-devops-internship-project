resource "aws_ecr_repository" "HCI-AWS-ECR-FRONTEND" {
  name = "hci-aws-${var.ecr_env}-ecr-frontend"
}

resource "aws_ecr_repository" "HCI-AWS-ECR-BACKEND" {
  name = "hci-aws-${var.ecr_env}-ecr-backend"
}
