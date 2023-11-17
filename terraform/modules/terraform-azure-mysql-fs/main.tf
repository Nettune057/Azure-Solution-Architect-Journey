# Manages the MySQL Flexible Server
resource "azurerm_mysql_flexible_server" "default" {
  location                     = var.location
  name                         = var.mysql_flexible_server_name
  resource_group_name          = var.resource_group_name
  administrator_login          = var.administrator_login
  administrator_password       = var.administrator_password
  backup_retention_days        = var.backup_retention_days
  delegated_subnet_id          = var.delegated_subnet_id
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled
  private_dns_zone_id          = azurerm_private_dns_zone.default.id
  sku_name                     = var.sku_name
  version                      = var.mysql_version
  zone                         = var.mysql_zone

  maintenance_window {
    day_of_week  = var.maintenance_window.day_of_week
    start_hour   = var.maintenance_window.start_hour
    start_minute = var.maintenance_window.start_minute
  }
  storage {
    iops    = var.storage.iops
    size_gb = var.storage.size_gb
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.default]
}

# Manages the MySQL Flexible Server Database
resource "azurerm_mysql_flexible_database" "main" {
  charset             = var.charset
  collation           = var.collation
  name                = var.mysql_flexible_database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.default.name
}