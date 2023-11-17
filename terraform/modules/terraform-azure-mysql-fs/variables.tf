variable "private_dns_zone_name" {}
variable "private_dns_zone_virtual_network_link_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "virtual_network_id" {}
variable "mysql_flexible_server_name" {}
variable "administrator_login" {}
variable "administrator_password" {}
variable "backup_retention_days" {}
variable "delegated_subnet_id" {}
variable "geo_redundant_backup_enabled" {}
variable "sku_name" {}
variable "mysql_version" {}
variable "mysql_zone" {}
variable "maintenance_window" {
  type = map
  default = {
    day_of_week = 0
    start_hour = 8
    start_minute = 0
  }
}

variable "storage" {
  type = map
  default = {
    iops = 360
    size_gb = 20
  }
}
variable "charset" {
  default = "utf8mb4"
}
variable "collation" {
  default = "utf8mb4_unicode_ci"
}
variable "mysql_flexible_database_name" {}
