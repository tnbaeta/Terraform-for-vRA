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

resource "azurerm_network_security_group" "brd_nsg" {
  count   = var.create_nsg == true ? 1 : 0
  name    = var.nsg_name
  location  = var.location
  resource_group_name = length(azurerm_resource_group.brd_rg) == 1 ? azurerm_resource_group.brd_rg[0].name : var.rg_name
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

resource "azurerm_network_security_rule" "brd_sr" {
  count												= var.create_sr == true ? 1 : 0
  name                        = "brd_sr"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = length(azurerm_resource_group.brd_rg) == 1 ? azurerm_resource_group.brd_rg[0].name : var.rg_name
  network_security_group_name = azurerm_network_security_group.brd_nsg[0].name
}

resource "azurerm_subnet" "brd_subnet" {
  name           = "${var.subnet[count.index].name}"
  virtual_network_name = azurerm_virtual_network.brd_vn.name
  resource_group_name = length(azurerm_resource_group.brd_rg) == 1 ? azurerm_resource_group.brd_rg[0].name : var.rg_name
  address_prefixes = "${var.subnet[count.index].address}"
  count          = "${length(var.subnet)}"
}
