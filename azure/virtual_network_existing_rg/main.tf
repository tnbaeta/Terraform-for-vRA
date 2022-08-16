terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.15.1"
    }   
  }
#  cloud {
#    organization = "illusion-factory-labs"
#    workspaces {
#      name = "brd"
#    }
#  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

resource "azurerm_network_security_group" "brd_nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.rg_name
}

resource "azurerm_virtual_network" "brd_vn" {
  name                = var.vn_name
  location            = var.location
  resource_group_name = azurerm_resource_group.brd_rg.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "brd_subnet" {
  name           = "${var.subnet_names[count.index]}"
  virtual_network_name = azurerm_virtual_network.brd_vn.name
  resource_group_name = azurerm_resource_group.brd_rg.name
  address_prefixes = ["${var.address_prefixes[count.index]}"]
  count          = "${length(var.subnet_names)}"
}
