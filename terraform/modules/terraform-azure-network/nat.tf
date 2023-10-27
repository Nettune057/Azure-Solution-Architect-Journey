resource "azurerm_nat_gateway" "nat" {
  count                     = local.create_NAT != false ? length(var.nat) : 0
  location                  = var.vnet_location
  name                      = lookup(var.nat[count.index], "nat_name", null)
  resource_group_name       = var.resource_group_name
  idle_timeout_in_minutes   = lookup(var.nat[count.index], "idle_timeout_in_minutes", 4)
  sku_name                  = lookup(var.nat[count.index], "sku_name", null)
  zones                     = lookup(var.nat[count.index], "az", [""])
  tags                      = var.tags
  depends_on                = [azurerm_virtual_network.vnet]
}

resource "azurerm_nat_gateway_public_ip_association" "natip" {
  count                     = local.create_NAT != false ? length(var.nat) : 0
  nat_gateway_id            = azurerm_nat_gateway.nat[count.index].id
  public_ip_address_id      = azurerm_public_ip.natpip[count.index].id
  depends_on                = [azurerm_virtual_network.vnet]
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat" {
  count          = length(var.nat)
  nat_gateway_id = azurerm_nat_gateway.nat[count.index].id
  subnet_id      = azurerm_subnet.server_subnet.id
  depends_on                = [azurerm_virtual_network.vnet]
}