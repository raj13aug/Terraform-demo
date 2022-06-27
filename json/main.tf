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

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "aws_s3_bucket" "devops_bucket" {
  bucket = "devops-ops-team"
}


# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning

resource "aws_s3_bucket_versioning" "devops_bucket" {
  bucket = aws_s3_bucket.devops_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


# Provides a S3 bucket server-side encryption configuration resource.
# The server-side encryption algorithm to use. Valid values are AES256 and aws:kms
# https://registry.terraform.io/providers/hashicorp%20%20/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration
resource "aws_s3_bucket_server_side_encryption_configuration" "devops_bucket" {
  bucket = aws_s3_bucket.devops_bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}



#Manages S3 bucket-level Public Access Block configuration.
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block

resource "aws_s3_bucket_public_access_block" "block-public-access" {
  bucket = aws_s3_bucket.devops_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

#Attaches a policy to an S3 bucket resource.
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy

resource "aws_s3_bucket_policy" "set-bucket-policy" {
  bucket = aws_s3_bucket.devops_bucket.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "SSLPolicy",
    "Statement" : [
      {
        "Sid" : "DenyInsecureConnections",
        "Effect" : "Deny",
        "Principal" : "*",
        "Action" : "s3:*",
        "Resource" : [
          "${aws_s3_bucket.devops_bucket.arn}",
          "${aws_s3_bucket.devops_bucket.arn}/*"
        ],
        "Condition" : {
          "Bool" : {
            "aws:SecureTransport" : "false"
          }
        }
      }
    ]
  })

}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.devops_bucket.arn
  description = "The ARN of the S3 bucket"
}