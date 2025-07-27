# provider "azurerm" {
#   features {}

#   client_id       = var.client_id
#   client_secret   = var.client_secret
#   tenant_id       = var.tenant_id
#   subscription_id = var.subscription_id
# }

module "vm" {
  source         = "./modules/vm"
  vm_public_key  = file("~/.ssh/id_rsa.pub")
  location       = "West US"
  vm_size        = "Standard_B1s"
}
