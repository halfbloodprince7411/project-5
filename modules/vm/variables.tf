# Required: SSH Public Key
variable "vm_public_key" {
  description = "Path to the public SSH key for VM access"
  type        = string
}

# Optional: Azure Region
variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "West US"
}

# Optional: VM Size
variable "vm_size" {
  description = "Size of the Virtual Machine (e.g., Standard_B1s)"
  type        = string
  default     = "Standard_B1s"
}
