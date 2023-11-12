variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to place the AKS nodes."
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource group to place the AKS cluster."
}

variable "api_server_subnet_id" {
  type        = string
  description = "The ID of the subnet to place the AKS API server."
}

variable "api_server_identity_id" {
  type        = string
  description = "The ID of the identity to assign to the AKS API server."
}

#variable "api_server_allowed_cidr_blocks" {
#  type        = list(string)
#  description = "The CIDR blocks allowed to access the AKS API server."
#}
