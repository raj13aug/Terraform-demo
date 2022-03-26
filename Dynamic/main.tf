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


resource "aws_instance" "myec2" {
  ami             = "ami-063e3af9d2cc7fe94"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.sg.name]

  tags = {
    Name = "Myec2instance"

  }

}

resource "aws_eip" "eip" {
  instance = aws_instance.myec2.id
}

resource "aws_security_group" "sg" {
  name = "allow_tls"

  dynamic "ingress" {
      iterator = port
      for_each = var.ingressrules
      content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
     }
   }

  dynamic "egress" {
       iterator = port
       for_each = var.engressrules
       content {
       from_port   = port.value
       to_port     = port.value
       protocol    = "TCP"
       cidr_blocks = ["0.0.0.0/0"]
       }
    }


}