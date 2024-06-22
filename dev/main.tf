terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.10.0"
    }
  }
}

# Provision VPC
module "vpc" {
  source = "../modules/vpc"
  env    = var.environment
}