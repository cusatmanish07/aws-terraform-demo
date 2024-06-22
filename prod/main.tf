terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.10.0"
    }
  }
}

# Data source to fetch information about  existing VPC 

data "aws_vpc" "prod-vpc" {
  id = var.vpc_id
}

# Data source to fetch information about existing Subnet
data "aws_subnet" "prod-subnet-id" {
  id = var.subnet_id
}

module "vpc" {
  source = "../modules/vpc"
  vpc_id = data.aws_vpc.prod-vpc.id
  env    = var.environment
}