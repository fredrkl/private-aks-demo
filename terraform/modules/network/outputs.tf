output "aks_subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.aks-data-plane.id
}

output "bastion_subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.bastion.id
}
