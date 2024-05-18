terraform {
  required_version = ">= 0.12"

  backend "local" {
    path = "terraform/terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
