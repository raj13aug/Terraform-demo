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
  region  = var.aws_region
}



resource "local_file" "resource_name" {
  filename = "/opt/resource.txt"
  content = "some content"
  directory_permission = "0777"
  file_permission = "0700"

 lifecycle {
   prevent_destroy = false
  }
}