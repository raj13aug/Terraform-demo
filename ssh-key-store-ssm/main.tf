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
  region                  = var.aws_region
}


#Creates a PEM (and OpenSSH) formatted private key
resource "tls_private_key" "ssh_generate" {
  algorithm = "RSA"
  rsa_bits  = 4096

}

#Create the aws_key_pair

resource "aws_key_pair" "generated" {
  key_name   = "ec2-key"
  public_key = tls_private_key.ssh_generate.public_key_openssh

}

# Provides a resource to manage AWS Secrets Manager secret metadata.
resource "aws_secretsmanager_secret" "secret" {
  description = "SSH keys for EC2 instance"
  name        = "Ec2-ssh-key-demo"

}

#AWS Secrets Manager secret version including its secret value.

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = tls_private_key.ssh_generate.private_key_pem
}