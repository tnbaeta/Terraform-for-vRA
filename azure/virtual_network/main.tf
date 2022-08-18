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

resource "azurerm_resource_group" "brd_rg" {
  count    = var.create_rg == true ? 1 : 0
  name     = var.rg_name
  location = var.location

}

resource "azurerm_virtual_network" "brd_vn" {
  name                = var.vn_name
  location            = var.location
  resource_group_name = length(azurerm_resource_group.brd_rg) == 1 ? azurerm_resource_group.brd_rg[0].name : var.rg_name
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "brd_subnet" {
  name           = "${var.subnet[count.index].name}"
  virtual_network_name = azurerm_virtual_network.brd_vn.name
  resource_group_name = length(azurerm_resource_group.brd_rg) == 1 ? azurerm_resource_group.brd_rg[0].name : var.rg_name
  address_prefixes = "${var.subnet[count.index].address}"
  count          = "${length(var.subnet)}"
}

resource "azurerm_network_interface" "brd_nic" {
  name                = "brd_nic"
  location            = var.location
  resource_group_name = length(azurerm_resource_group.brd_rg) == 1 ? azurerm_resource_group.brd_rg[0].name : var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.brd_subnet[0].id
    private_ip_address_allocation = "Dynamic"
  }
}
