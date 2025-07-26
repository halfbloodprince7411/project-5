provider "azurerm" {
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}


resource "azurerm_resource_group" "rg" {
  name     = "rg-death-eaters-${random_pet.name.id}"
  location = "West US"
}

# resource "azurerm_app_service_plan" "plan" {
#   name                = "asp-lightweight"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   kind                = "Linux"
#   reserved            = true

#   sku {
#     tier = "Basic"
#     size = "B1"
#   }
# }

# resource "azurerm_app_service" "app" {
#   name                = "lightweight-app-${random_pet.name.id}"
#   location            = azurerm_resource_group.rg.location
#   resource_group_name = azurerm_resource_group.rg.name
#   app_service_plan_id = azurerm_app_service_plan.plan.id

#   site_config {
#     linux_fx_version = "NODE|14-lts" # Feel free to change this to your runtime
#   }

#   https_only = true
# }

resource "random_pet" "name" {
  length    = 2
  separator = "-"
}
