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
  region  = var.location
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "AppServerInstance"
  }
}

resource "null_resource" "health_check" {
  triggers = {
  trigger = timestamp()
  }

  provisioner "local-exec" {
    command = "/bin/bash healthcheck.sh"
  }
}