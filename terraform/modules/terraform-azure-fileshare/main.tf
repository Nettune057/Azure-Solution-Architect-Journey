resource "azurerm_storage_account" "fileacc" {
  name                      = var.storage_account_name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_kind              = var.account_kind
  account_tier              = local.account_tier
  enable_https_traffic_only = true
  min_tls_version           = var.min_tls_version
  account_replication_type = local.account_replication_type
  public_network_access_enabled = true
  tags                      = var.tags

  dynamic "network_rules" {
    for_each = var.network_rules != null ? ["true"] : []
    content {
      default_action             = "Deny"
      bypass                     = var.network_rules.bypass
      ip_rules                   = var.network_rules.ip_rules
      virtual_network_subnet_ids = var.network_rules.subnet_ids
    }
  }
}