terraform {
  backend "s3" {
    bucket         = "dev-tfstate-manish"
    key            = "dev-backend.tfstate"
    dynamodb_table = "dev-tfstate-manish"
    region         = "us-west-1"
  }
}