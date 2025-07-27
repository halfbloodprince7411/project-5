provider "azurerm" {
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  use_cli         = false
}

resource "random_pet" "name" {
  length    = 2
  separator = "-"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-death-eaters-${random_pet.name.id}"
  location = var.location
}

# Use the vnet module
module "vnet" {
  source              = "../../modules/vnet"
  name                = var.vnet_name
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space
}

# Example: Subnet using vnet module output
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-${module.vnet.vnet_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = module.vnet.vnet_name
  address_prefixes     = ["10.0.1.0/24"]
}
