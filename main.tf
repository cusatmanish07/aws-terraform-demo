# locals {
#   //environment = terraform.workspace
# }
#
# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 5.10.0"
#     }
#   }
#   backend "s3" {
#     key = terraform.workspace == "dev" ? "dev-backend.tfstate" : "prod-backend.tfstate"
#   }
# }
#
#
# provider "aws" {
#   region = terraform.workspace == "dev" ? "us-west-1" : "us-west-2"
# }
#
# # Data source to fetch information about  existing VPC
#
# data "aws_vpc" "selected" {
#   id = var.vpc_id
# }
#
# # Data source to featch information about existing Subnet
# data "aws_subnet" "selected" {
#   id = var.subnet_id
# }
#
# # Create a security group resource
#
# resource "aws_security_group" "aws-sg-1" {
#   name        = "aws-sg-1"
#   description = "testing sg"
#   vpc_id      = data.aws_vpc.selected.id
#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }