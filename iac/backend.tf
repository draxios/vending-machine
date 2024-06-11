provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "your_terraform_organization"

    workspaces {
      name = "your_workspace_name"
      # Alternatively, you can use a prefix for dynamically named workspaces
      # prefix = "your_workspace_prefix"
    }
  }
}
