terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}



resource "aws_ecr_repository" "product" {
  name                 = "eks-product"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "EKS"
  }
}

data "aws_ecr_authorization_token" "token" {
  depends_on = [aws_ecr_repository.product]
}

data "aws_caller_identity" "current" {}

locals {
  repo_url    = aws_ecr_repository.product.repository_url
  name_suffix = var.resource_tags
}

locals {
  repo_name = trimprefix(local.repo_url, local.name_suffix)
}


module "ecr_mirror" {
  source         = "TechToSpeech/ecr-mirror/aws"
  version        = "0.0.8"
  docker_source  = "wordpress"
  aws_profile    = "terraform"
  aws_account_id = data.aws_caller_identity.current.account_id
  aws_region     = "us-east-1"
  ecr_repo_name  = local.repo_name
  ecr_repo_tag   = "wordpress"
  depends_on     = [data.aws_ecr_authorization_token.token]
}