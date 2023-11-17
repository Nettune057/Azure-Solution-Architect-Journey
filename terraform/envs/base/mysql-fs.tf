module "mysql-fs" {
  source = "../../modules/terraform-azure-mysql-fs"

  administrator_login                        = var.administrator_login
  administrator_password                     = var.administrator_password
  backup_retention_days                      = var.backup_retention_days
  delegated_subnet_id                        = module.vnet.database_subnet_id
  geo_redundant_backup_enabled               = var.geo_redundant_backup_enabled
  location                                   = local.rg_location
  mysql_flexible_database_name               = "${local.prefix_name}-${var.mysql_flexible_database_name}"
  mysql_flexible_server_name                 = "${var.setup_name}-${var.env}-${var.mysql_flexible_server_name}"
  mysql_version                              = var.mysql_version
  private_dns_zone_name                      = "${var.setup_name}${var.env}.mysql.database.azure.com"
  private_dns_zone_virtual_network_link_name = var.private_dns_zone_virtual_network_link_name
  resource_group_name                        = local.rg_name
  sku_name                                   = var.sku_name
  virtual_network_id                         = module.vnet.virtual_network_id
  mysql_zone                                 = var.mysql_zone
  depends_on                                 = [module.vnet]

  maintenance_window = {
      day_of_week  = 0
      start_hour   = 8
      start_minute = 0
    }


  storage = {
      iops = 360
      size_gb = 20
    }
}