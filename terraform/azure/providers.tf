terraform {
  required_version = ">= 0.12"

  backend "local" {
    path = "terraform/terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }
}

provider "azurerm" {
  features {}
}
