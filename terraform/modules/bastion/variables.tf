variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to place the AKS nodes."
}
