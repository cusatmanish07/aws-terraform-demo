terraform {
  backend "s3" {
    bucket         = "prod-tfstate-manish"
    key            = "prod-backend.tfstate"
    region         = "us-west-2"
    dynamodb_table = "prod-tfstate-manish"
  }
}