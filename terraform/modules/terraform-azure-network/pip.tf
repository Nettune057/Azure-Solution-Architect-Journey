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

resource "azurerm_public_ip" "natpip" {
  count               = local.create_public_ip != false ? length(var.natpip) : 0
  allocation_method   = lookup(var.natpip[count.index], "allocation_method", null)
  sku                 = var.SKU
  location            = var.vnet_location
  name                = lookup(var.natpip[count.index], "natpip_name", null)
  resource_group_name = var.resource_group_name
  zones               = lookup(var.natpip[count.index], "az", [""])
  tags                = var.tags
}