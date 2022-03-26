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


# Get latest AMI ID for Amazon Linux2 OS

data "aws_ami" "amzlinux" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}


# Create EC2 Instance - Amazon Linux

resource "aws_instance" "app_server" { 
  ami           = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"

  tags = {
    Name = "app-linux-vm"
  }
}


# Create EC2 Instance - Amazon Linux

resource "aws_instance" "db_server" { 
  ami           = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"

  tags = {
    Name = "db-linux-vm"
  }
}