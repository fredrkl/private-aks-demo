variable "location" {
  type        = string
  description = "The location for the resource group."

  validation {
    condition     = contains(["eastus", "northeurope"], var.location)
    error_message = "The location must be between eastus and northeurope."
  }
}

variable "name_prefix" {
  type        = string
  description = "The prefix for the resource group."

  validation {
    condition     = length(var.name_prefix) <= 10
    error_message = "The prefix must be less than 10 characters."
  }
}
variable "enable_bastion" {
  description = "Feature flag to control the creation of the bastion module resources"
  type        = bool
  default     = true
}

variable "bastion_admin_password" {
  description = "value of the admin password for the bastion host"
  type        = string
  sensitive   = true
}
variable "enable_aks" {
  description = "Feature flag to control the creation of the aks module resources"
  type        = bool
  default     = true
}

