terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "remote" {
    organization = "terraform_hatchman76"

    workspaces {
      name = "oidc-test-workspace"
    }
  }
}

variable "AWS_REGION" {
  type = string
  default = "us-west-2"
}

variable "AWS_ROLE_ARN" {
  type = string
}
provider "aws" {
  region  = var.AWS_REGION
  assume_role {
    role_arn     = var.AWS_ROLE_ARN
    session_name = "terraform-oidc-session"
  }
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "terraform-cloud-oidc-bucket"

  tags = {
    Environment = "Test"
  }
}

resource "aws_s3_bucket_public_access_block" "name" {
  bucket = aws_s3_bucket.test_bucket.id

  # Recommended approach: Use S3 Block Public Access
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}
