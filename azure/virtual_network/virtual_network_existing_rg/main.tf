terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.18.0"
    }   
  }
}

provider "azurerm" {
  # Configuration options
  features {}
}

resource "azurerm_network_security_group" "brd_sg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.rg_name

  }

resource "azurerm_virtual_network" "brd_vn" {
  name                = var.vn_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "brd_subnet" {
  name           = "${var.subnet[count.index].name}"
  virtual_network_name = azurerm_virtual_network.brd_vn.name
  resource_group_name = var.rg_name
  address_prefixes = "${var.subnet[count.index].address}"
  count          = "${length(var.subnet)}"
}
