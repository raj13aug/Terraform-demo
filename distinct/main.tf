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
  shared_credentials_file = "C:/Users/raj13/.aws/credentials"
  region                  = "us-east-1"
}


data "http" "primary-server" {
  url = "https://ip-ranges.amazonaws.com/ip-ranges.json"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}


locals {
  s3_ips = try(distinct([
    for items in jsondecode(data.http.primary-server.body).prefixes :
    items.ip_prefix if items.service == "S3"
  ]), "NO LIST PROVIDED IN LOCALS SERVICES VARIABLE")

}


