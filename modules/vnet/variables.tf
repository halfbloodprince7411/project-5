variable "name" {
  description = "Name of the virtual network"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "address_space" {
  description = "The address space that is used by the virtual network"
  type        = list(string)
}

variable "name" {
  type        = string
  description = "Name of the virtual network"
}
