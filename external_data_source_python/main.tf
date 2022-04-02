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


data "external" "todo" {
  
  program = ["python", "${path.module}/fetch_todo.py"]
  query = {
    id = var.todo_id
  }
}

locals {
  todo = data.external.todo.result
}