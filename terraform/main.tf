provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks" {
  name     = "${var.name_prefix}-private-aks"
  location = var.location
}

module "network" {
  source         = "./modules/network"
  resource_group = azurerm_resource_group.aks
}

module "aks" {
  source         = "./modules/aks"
  resource_group = azurerm_resource_group.aks
  subnet_id      = module.network.aks_dataplane_subnet_id

  count = var.enable_aks ? 1 : 0
}

module "bastion" {
  source             = "./modules/bastion"
  resource_group     = azurerm_resource_group.aks
  subnet_id          = module.network.jumphost_subnet_id
  subnet_jumphost_id = module.network.jumphost_subnet_id

  count = var.enable_bastion ? 1 : 0
}

# Moved resources
moved {
  from = module.aks.azurerm_virtual_network.example
  to   = module.network.azurerm_virtual_network.example
}

moved {
  from = module.aks.azurerm_subnet.aks-data-plane
  to   = module.network.azurerm_subnet.aks-data-plane
}

moved {
  from = module.aks.azurerm_network_security_group.example
  to   = module.network.azurerm_network_security_group.example
}

moved {
  from = module.aks.azurerm_subnet_network_security_group_association.example
  to   = module.network.azurerm_subnet_network_security_group_association.example
}

# Provider and backend
terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.77.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "terraform-state-files"
    storage_account_name = "terraformdemostatefiles"
    container_name       = "private-aks-demo-tfstate"
    key                  = "terraform.tfstate"
  }
}
