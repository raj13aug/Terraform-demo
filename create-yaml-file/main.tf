terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  shared_credentials_file = "C:/Users/raj13/.aws/credentials"
  region                  = var.aws_region
}


resource "local_file" "deployment_template" {
  content = templatefile("deployment_template.yaml", {
    image = "nginx:1.14.2"
    }
  )
  filename = "deployment.yaml"
}