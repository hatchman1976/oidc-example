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

provider "aws" {
  region  = "us-west-2"
  assume_role {
    role_arn     = "arn:aws:iam::736654693886:role/oidc-example-role"
    session_name = "terraform-oidc-session"
  }
}

resource "aws_s3_bucket" "test_bucket" {
  bucket = "terraform-cloud-oidc-bucket"
  acl    = "private"

  tags = {
    Environment = "Test"
  }
}
