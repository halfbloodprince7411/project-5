variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}

# 🔑 Public SSH key injected via CI
variable "vm_public_key" {
  type        = string
  description = "The SSH public key for the VM admin user"
}
