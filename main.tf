provider "azurerm" {
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  use_cli = false
}

# 🐾 Generate spooky pet-style names
# resource "random_pet" "name" {
#   length    = 2
#   separator = "-"
# }

# # ☠️ Resource Group
# resource "azurerm_resource_group" "rg" {
#   name     = "rg-death-eaters-${random_pet.name.id}"
#   location = "West US"
# }

# 🌐 Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${random_pet.name.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

# 🧵 Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-${random_pet.name.id}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 🌎 Public IP
resource "azurerm_public_ip" "public_ip" {
  name                = "pip-${random_pet.name.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

# 🔌 Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "nic-${random_pet.name.id}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# 💻 Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-${random_pet.name.id}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s" # ✅ ultra-budget tier

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
    environment = "dev"
    owner       = "sirisha"
    cost        = "minimal"
    name        = random_pet.name.id
  }
}