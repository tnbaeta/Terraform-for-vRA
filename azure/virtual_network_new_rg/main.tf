terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.15.1"
    }   
  }
#  cloud {
 #   organization = "illusion-factory-labs"
  #  workspaces {
   #   name = "brd"
   # }
  #}
}

provider "azurerm" {
  # Configuration options
  features {}
}

resource "azurerm_resource_group" "brd_rg" {
  name     = var.rg_name
  location = var.location
}

resource "azurerm_network_security_group" "brd_nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.brd_rg.location
  resource_group_name = azurerm_resource_group.brd_rg.name
}

resource "azurerm_virtual_network" "brd_vn" {
  name                = var.vn_name
  location            = azurerm_resource_group.brd_rg.location
  resource_group_name = azurerm_resource_group.brd_rg.name
  address_space       = "${var.address_space}"
  dns_servers         = "${var.dns_servers}"

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "brd_subnet" {
  name           = "${var.subnet_names[count.index]}"
  virtual_network_name = "${azurerm_virtual_network.brd_vn.name}"
  resource_group_name = "${azurerm_resource_group.brd_rg.name}"
  address_prefixes = ["${var.address_prefixes[count.index]}"]
  count          = "${length(var.subnet_names)}"
}
