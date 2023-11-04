#provider "azurerm" {
#  features {}
#}

resource "azurerm_public_ip" "bastion" {
  name                = "example-bastion-pip"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "example" {
  name                = "example-bastion"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}

#terraform {
#  required_version = ">= 1.6"
#  required_providers {
#    azurerm = {
#      source  = "hashicorp/azurerm"
#      version = "3.77.0"
#    }
#  }
#}
