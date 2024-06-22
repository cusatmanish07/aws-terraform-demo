variable "env" {
  type = string
}

variable "availability_zone" {
  type = string
  default = "us-west-1a"
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

