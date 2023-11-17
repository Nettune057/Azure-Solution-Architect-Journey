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

output "virtual_network_id" {
  value = azurerm_virtual_network.vnet.id
}

output "database_subnet_id" {
  value = azurerm_subnet.database_subnet.id
}

output "virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
}
output "database_subnet_name" {
  value = azurerm_subnet.database_subnet.name
}

output "database_public_ip_address_id" {
  value = azurerm_public_ip.pip[1].id
}

output "appgw_subnet_name" {
  value = azurerm_subnet.appgw_subnet.name
}

output "appgw_public_ip_address_id" {
  value = azurerm_public_ip.pip[0].id
}

output "appgw_public_ip_address_ip" {
  value = azurerm_public_ip.pip[0].ip_address
}