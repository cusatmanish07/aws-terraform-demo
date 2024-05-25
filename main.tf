locals {
  //environment = terraform.workspace
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.10.0"
    }
  }
  backend "s3" {
    key = terraform.workspace == "dev" ? "dev-backend.tfstate" : "prod-backend.tfstate"
  }
}


provider "aws" {
  region = terraform.workspace == "dev" ? "us-west-1" : "us-west-2"
}


