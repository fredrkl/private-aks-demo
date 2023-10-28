provider "azurerm" {
  features {}
}

variables {
  name_prefix = "test"
  location    = "eastus"
}

run "valid_resource_group" {

  command = plan

  assert {
    condition     = azurerm_resource_group.aks.name == "test-tf-aks"
    error_message = "Resource group name is not as expected"
  }
}
