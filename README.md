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

> :information_source: **Az cli preview**: Be sure to install the [az cli preview version](https://learn.microsoft.com/en-US/azure/aks/api-server-vnet-integration#install-the-aks-preview-azure-cli-extension) to be able to use the `az aks update` command.

The [terraform workflow](.github/workflows/terraform.yaml), will create the amongst others, an AKS cluster with _VNetIntegration_.

If you wanted you can turn on and off the public IP. A bastion host is used to access a private cluster. Following the guide at:
<https://learn.microsoft.com/en-US/azure/aks/api-server-vnet-integration#enable-or-disable-private-cluster-mode-on-an-existing-cluster-with-api-server-vnet-integration>.

For the jump-host this repo creates a Linux VM with the _Azure AD SSH Login for Linux_ extension installed. This enables us to login using our Azure AD credentials, e.g.,
  
```bash
az network bastion ssh --name "<BastionName>" --resource-group "<ResourceGroupName>" --target-resource-id "<VMResourceId or VMSSInstanceResourceId>" --auth-type "AAD"
```

## Resources

- [AKS Networking Update - John Savill's Technical Training](https://www.youtube.com/watch?v=54y986U1uYM)
- [Terraform provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#vnet_integration_enabled)
- [Azure Kubernetes Service with VNet Integration doc](https://learn.microsoft.com/en-US/azure/aks/api-server-vnet-integration)
- [Azure Kubernetes Service with VNet Integration - bring your own VNet doc](https://learn.microsoft.com/en-US/azure/aks/api-server-vnet-integration#create-a-private-aks-cluster-with-api-server-vnet-integration-using-bring-your-own-vnet)

## Notes

- It is not possible to enable K8s API server whitelist when using VNet integration and private cluster.
- Due to an [Azure Bastion limitation](https://learn.microsoft.com/en-us/answers/questions/409639/enable-azure-ad-login-with-bastion-on-exisitng-vm) it is not possible to RDP or SSH using Azure AD login through the portal. You have to use the AZ CLI command like the example above.

## Build status

[![Terraform](https://github.com/fredrkl/private-aks-demo/actions/workflows/terraform.yaml/badge.svg)](https://github.com/fredrkl/private-aks-demo/actions/workflows/terraform.yaml)
