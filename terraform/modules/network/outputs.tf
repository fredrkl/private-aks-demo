output "aks_dataplane_subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.aks-data-plane.id
}

output "bastion_subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.bastion.id
}

output "api_server_subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.api-server.id
}

output "jumphost_subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.jumphost_subnet_id.id
}
