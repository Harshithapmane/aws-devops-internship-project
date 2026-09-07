variable "environment" {
  type    = string
  default = "DEV"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "execution_role_arn" {
  type    = string
  default = "arn:aws:iam::<your-account-id>:role/ecsTaskExecutionRole"
}

variable "ecr_env" {
  type    = string
  default = "dev"
}
