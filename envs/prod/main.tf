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
  name     = "rg-death-eaters-${random_pet.name.id}-${var.environment}"
  location = var.location
}

module "vnet" {
  source              = "../../modules/vnet"
  name                = "${var.vnet_name}-${random_pet.name.id}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-${random_pet.name.id}-${var.environment}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = module.vnet.vnet_name
  address_prefixes     = var.subnet_address_prefixes

}

resource "azurerm_public_ip" "public_ip" {
  name                = "pip-${random_pet.name.id}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-${random_pet.name.id}-${var.environment}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-${random_pet.name.id}-${var.environment}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  size                = "Standard_B1s"

  admin_username      = "ubuntu"
  admin_ssh_key {
    username   = "ubuntu"
    public_key = var.vm_public_key
  }

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "22.04.202212010"
  }

  tags = {
    environment = var.environment
    owner       = "sirisha"
    cost        = "minimal"
    name        = random_pet.name.id
  }
}
