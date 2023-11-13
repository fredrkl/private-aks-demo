resource "azurerm_kubernetes_cluster" "example" {
  name                = "example-aks"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  dns_prefix          = "exampleaks"

  default_node_pool {
    name           = "default"
    node_count     = 1
    vm_size        = "Standard_D2_v2"
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.api_server_identity_id]
  }

  lifecycle {
    ignore_changes = [
      azure_policy_enabled
    ]
  }

  role_based_access_control_enabled = true
  private_cluster_enabled           = true

  network_profile {
    network_plugin    = "azure"
    network_policy    = "calico"
    dns_service_ip    = "10.0.0.10"
    service_cidr      = "10.0.0.0/16"
    load_balancer_sku = "standard"
  }

  api_server_access_profile {
    vnet_integration_enabled = true
    subnet_id                = var.api_server_subnet_id
  }

  tags = {
    Environment = "Production"
  }
}
