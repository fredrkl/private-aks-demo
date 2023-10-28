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
