resource "azurerm_cdn_profile" "cdn-profile" {
  count               = var.enable_static_website && var.enable_cdn_profile ? 1 : 0
  name                = var.cdn_profile_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.cdn_sku_profile
  tags                = merge({ "Name" = format("%s", var.cdn_profile_name) }, var.tags, )
  depends_on = [ azurerm_resource_group.rg ]
}

#resource "random_string" "unique" {
#  count   = var.enable_static_website && var.enable_cdn_profile ? 1 : 0
#  length  = 8
#  special = false
#  upper   = false
#}

resource "azurerm_cdn_endpoint" "cdn-endpoint" {
  name                          = var.cdn_profile_name
  profile_name                  = azurerm_cdn_profile.cdn-profile.0.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  origin_host_header            = azurerm_storage_account.storeacc.primary_web_host
  querystring_caching_behaviour = "IgnoreQueryString"

  origin {
    name      = "websiteorginaccount"
    host_name = azurerm_storage_account.storeacc.primary_web_host
  }
  depends_on = [ azurerm_cdn_profile.cdn-profile ]
}