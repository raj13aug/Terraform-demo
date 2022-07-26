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

resource "aws_instance" "app_server" {
  instance_type = "t2.micro"
  count         = 2
  ami           = "ami-830c94e3"

  tags = {
    Name = "${var.env_name}-${format("%s", element(var.aws_instance_names, count.index))}"
  }
}

