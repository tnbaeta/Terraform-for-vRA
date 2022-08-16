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
  name     = var.rg_name
  location = var.location

	lifecycle {
    # The AMI ID must refer to an existing AMI that has the tag "nomad-server".
    postcondition {
      condition     = var.create_rg == true
      error_message = "Create RG must be checked"
    }
  }
}

resource "azurerm_virtual_network" "brd_vn" {
  name                = var.vn_name
  location            = azurerm_resource_group.brd_rg.location
  resource_group_name = azurerm_resource_group.brd_rg.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "brd_subnet" {
  name           = "${var.subnet[count.index].name}"
  virtual_network_name = azurerm_virtual_network.brd_vn.name
  resource_group_name = azurerm_resource_group.brd_rg.name
  address_prefixes = "${var.subnet[count.index].address}"
  count          = "${length(var.subnet)}"
}
