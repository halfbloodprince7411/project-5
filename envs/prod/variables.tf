variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for the environment"
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the VNet"
}

variable "vm_public_key" {
  type        = string
  description = "The SSH public key for the VM admin user"
}
