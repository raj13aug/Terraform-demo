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
  region                  = var.location
}


resource "aws_instance" "db_server" {
  for_each      = var.db_apps
  ami           = each.value["ami"]
  instance_type = "t2.micro"

  tags = {
    Name = each.value["name"]
  }
}

resource "aws_instance" "app_server" {
  for_each      = var.web_apps
  ami           = each.value["ami"]
  instance_type = "t2.micro"
  depends_on    = [aws_instance.db_server]

  tags = {
    Name = each.value["name"]
  }
}
