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


variable "os" {
  default = "linux"

  validation {
    # The condition here identifies if the variable contains the string "linxu" OR "windows".
    #regex(pattern, string)
    condition = can(regex("linux|windows", var.os))
    error_message = "ERROR: Operating System must be Windows OR Linux."
  }
}


