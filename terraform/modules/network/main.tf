resource "azurerm_virtual_network" "example" {
  name                = "example-vnet"
  address_space       = ["10.1.0.0/22"]
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}

resource "azurerm_subnet" "aks-data-plane" {
  name                 = "aks-data-plane"
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.1.0.0/23"]
}

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.1.2.0/27"]
}

resource "azurerm_subnet" "api-server" {
  name                 = "api-server"
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.1.3.0/27"]
}
resource "azurerm_subnet" "jumphost_subnet_id" {
  name                 = "jumphost_subnet_id"
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.1.3.32/27"]
}

resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.aks-data-plane.id
  network_security_group_id = azurerm_network_security_group.example.id
}
