variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "aks_identity_id" {
  type        = string
  description = "Value of aks identity id"
}
