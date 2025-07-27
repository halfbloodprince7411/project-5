variable "client_id" {
  description = "Azure Client ID for Service Principal"
}

variable "client_secret" {
  description = "Azure Client Secret for Service Principal"
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure Tenant ID"
}

variable "subscription_id" {
  description = "Azure Subscription ID"
}
