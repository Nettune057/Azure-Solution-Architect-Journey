resource "azurerm_virtual_network" "vnet" {
  address_space       = var.address_space
  location            = var.vnet_location
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "subnet" {
  count                = local.create_subnet != false ? length(var.subnet) : 0
  address_prefixes     = lookup(var.subnet[count.index], "address_prefixes", null)
  name                 = lookup(var.subnet[count.index], "subnet_name",null )
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_public_ip" "pip" {
  count               = local.create_public_ip != false ? length(var.pip) : 0
  allocation_method   = lookup(var.pip[count.index], "allocation_method", null)
  sku                 = var.SKU
  location            = var.vnet_location
  name                = lookup(var.pip[count.index], "pip_name", null)
  resource_group_name = var.resource_group_name
  zones               = lookup(var.pip[count.index], "az", [""])
  tags                = var.tags
}

resource "azurerm_nat_gateway" "nat" {
  count                     = local.create_NAT != false ? length(var.nat) : 0
  location                  = var.vnet_location
  name                      = lookup(var.nat[count.index], "nat_name", null)
  resource_group_name       = var.resource_group_name
  idle_timeout_in_minutes   = lookup(var.nat[count.index], "idle_timeout_in_minutes", 4)
  sku_name                  = lookup(var.nat[count.index], "sku_name", null)
  zones                     = lookup(var.nat[count.index], "az", [""])
  tags                      = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "natip" {
  for_each                  = var.nat
  nat_gateway_id            = azurerm_nat_gateway.nat[each.key].id
  public_ip_address_id      = azurerm_public_ip.pip[2].id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat" {
  for_each       = var.nat
  nat_gateway_id = azurerm_nat_gateway.nat[each.key].id
  subnet_id      = each.value["subnet_id"]
}

resource "" "" {}