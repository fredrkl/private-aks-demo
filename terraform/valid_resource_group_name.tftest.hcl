provider "azurerm" {
  features {}
}

variables {
  name_prefix            = "test"
  location               = "eastus"
  bastion_admin_password = "P@ssw0rd1234"
}

run "valid_resource_group" {

  command = plan

  assert {
    condition     = azurerm_resource_group.aks.name == "test-private-aks"
    error_message = "Resource group name is not as expected"
  }
}
