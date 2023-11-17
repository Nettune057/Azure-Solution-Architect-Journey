resource "azurerm_private_dns_zone" "default" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
}

# Enables you to manage Private DNS zone Virtual Network Links
resource "azurerm_private_dns_zone_virtual_network_link" "default" {
  name                  = var.private_dns_zone_virtual_network_link_name
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = var.virtual_network_id
}