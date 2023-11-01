locals {
  account_tier              = (var.account_kind == "FileStorage" ? "Premium" : split("_", var.sku)[0])
  account_replication_type  = (local.account_tier == "Premium" ? "LRS" : split("_", var.sku)[1])
  if_static_website_enabled = var.enable_static_website ? [{}] : []
}
