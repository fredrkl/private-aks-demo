provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks" {
  name     = "${var.name_prefix}-private-aks"
  location = var.location
}

module "aks" {
  source         = "./modules/network"
  resource_group = azurerm_resource_group.aks
}

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
