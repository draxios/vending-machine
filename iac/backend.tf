provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "path/to/your/terraform.tfstate"
    region = "us-east-1"
  }
}
