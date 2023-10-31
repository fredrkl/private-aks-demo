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
