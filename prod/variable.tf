variable "environment" {
  type    = string
  default = "prod"
}

variable "region" {
  type    = string
  default = "us-west-2"
}

variable "vpc_id" {
  type    = string
  default = "vpc-0dbb91f9807f48e9a"
}

variable "subnet_id" {
  type    = string
  default = "subnet-04f97f4dabeae16bc"
}


variable "availability_zone" {
  type = string
  default = "us-west-2a"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  type = string
  default = "10.0.2.0/24"
}