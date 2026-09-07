terraform {
  required_version = ">=0.12.16"

  backend "s3" {
    bucket = "hci-aws-infra-bucket"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}
