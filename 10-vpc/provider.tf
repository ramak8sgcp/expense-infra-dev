terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.66.0"
    }
  }
  # makesure we below S3 and DynamoDB should be there
  backend "s3" {
    bucket         = "81s-remote-state-dev-rama"
    key            = "expense-vpc-infra-dev"
    region         = "us-east-1"
    dynamodb_table = "81s-locking"

  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}