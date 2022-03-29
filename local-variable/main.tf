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


locals {
  bucket-name = "${var.app_name}-${var.environment_name}-bucket-${var.aws_region}"
}


resource "aws_s3_bucket" "mys3bucket" {
  bucket = local.bucket-name
  tags = {
    Environment = var.environment_name
  }
}