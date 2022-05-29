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
  # This returns the sync token from the endpoint, the return value is of the type string.
  syncToken = try(jsondecode(data.http.primary-server.body).syncToken1,
    "NO TOKEN AVAILABLE"
  )
}
