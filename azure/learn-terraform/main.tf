terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.15.1"
    }
  }
  cloud {
    organization = "illusion-factory-labs"
    workspaces {
      name = "learn-terraform"
    }
  }
}

provider "azurerm" {
  features {}
	
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "westus2"
}
