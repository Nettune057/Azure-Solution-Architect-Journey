resource "azurerm_subnet" "appgw_subnet" {
  address_prefixes     = var.address_prefixes_appgw
  name                 = var.appgw_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "server_subnet" {
  address_prefixes     = var.address_prefixes_server
  name                 = var.server_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  service_endpoints = ["Microsoft.Storage"]
}

resource "azurerm_subnet" "database_subnet" {
  address_prefixes     = var.address_prefixes_database
  name                 = var.database_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "bastion_subnet" {
  address_prefixes     = var.address_prefixes_bastion
  name                 = var.bastion_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}