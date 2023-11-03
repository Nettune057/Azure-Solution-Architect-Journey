output "bastion_subnet" {
  value = azurerm_subnet.bastion_subnet.id
}

output "bastion_pip" {
  value = azurerm_public_ip.pip[1].id
}

output "server_subnet" {
  value = azurerm_subnet.server_subnet.id
}

output "network_security_group_id" {
  value = azurerm_network_security_group.nsg.id
}