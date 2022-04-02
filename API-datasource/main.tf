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


data "http" "this" {
  url             = "https://jsonplaceholder.typicode.com/todos/${var.todo_id}"
  request_headers = {
    Accept        = "application/json"
  }
}