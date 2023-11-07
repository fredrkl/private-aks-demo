resource "azurerm_user_assigned_identity" "example" {
  name                = "aks-identity"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
}
