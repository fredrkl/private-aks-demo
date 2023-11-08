output "aks_identity_id" {
  description = "The ID of the identity"
  value       = azurerm_user_assigned_identity.example.client_id
}
