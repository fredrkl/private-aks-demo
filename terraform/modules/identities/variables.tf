variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource group to place the identities in."
}
