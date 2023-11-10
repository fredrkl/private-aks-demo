# Private AKS built with Terraform and GH-Actions demo

## Prerequisites

- Fork this repo
- Create a new _Azure Entra Application_ and with _Federated credentials_ assigned to your repo.
- Create the following GH Actions secrets:
  - `azure_client_id`: The _Application (client) ID_ of the _Azure AD Application_.
  - `azure_tenant_id`: The _Directory (tenant) ID_ of the _Azure AD Application_.
  - `azure_subscription_id`: The _Subscription ID_ of the _Azure Subscription_.
- Be sure to give the _Azure Entra Application_ you created permissions to the _Azure Subscription_ you are going to use.
- Create a storage account and update the main.tf backend configuration with the storage account name and container name.
- Be sure to give the _Azure Entra Application_ you created permissions to the _Storage Account_ you are going to use with the _Storage Blob Data Contributor_ role and _Storage Account Key Operator Service Role_ role.

## Pre-commit hooks for terraform files (optional)

> :exclamation: The pre-commit hooks are only running on staged files.

To set up pre-commit hooks for terraform files, run the following commands:

```bash
brew install pre-commit
pre-commit install
```

If you want to uninstall the pre-commit hooks, run the following command:

```bash
pre-commit uninstall
```

## Terraform

### Feature flags

There are 2 feature flags located in the main [variable.tf](terraform/variables.tf) file that can be used to enable/disable features.

- Enable Bastion
- Enable AKS

## Guide

The [terraform workflow](.github/workflows/terraform.yaml), will create the amongst others, an AKS cluster with _VNetIntegration_.

Now the AKS cluster has a public IP but the communication between the API server and the nodes are private.

## Resources

- [AKS Networking Update - John Savill's Technical Training](https://www.youtube.com/watch?v=54y986U1uYM)
- [Terraform provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#vnet_integration_enabled)
- [Azure Kubernetes Service with VNet Integration doc](https://learn.microsoft.com/en-US/azure/aks/api-server-vnet-integration)
- [Azure Kubernetes Service with VNet Integration - bring your own VNet doc](https://learn.microsoft.com/en-US/azure/aks/api-server-vnet-integration#create-a-private-aks-cluster-with-api-server-vnet-integration-using-bring-your-own-vnet)

## Build status

[![Terraform](https://github.com/fredrkl/private-aks-demo/actions/workflows/terraform.yaml/badge.svg)](https://github.com/fredrkl/private-aks-demo/actions/workflows/terraform.yaml)
