output "vm_name" {
  description = "Generated VM name"
  value       = azurerm_linux_virtual_machine.vm.name
}

output "public_ip" {
  description = "Public IP of the VM"
  value       = azurerm_public_ip.public_ip.ip_address
}

output "resource_group_name" {
  description = "Name of the created Resource Group"
  value       = azurerm_resource_group.rg.name
}
