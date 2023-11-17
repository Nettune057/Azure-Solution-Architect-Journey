variable "administrator_login" {}
variable "administrator_password" {}
variable "backup_retention_days" {
  default = 7
}
variable "geo_redundant_backup_enabled" {
  default = false
}

variable "mysql_flexible_database_name" {
  default = "mysqlfsdatabase"
}
variable "mysql_flexible_server_name" {
  default = "mysqlfs"
}
variable "mysql_version" {
  default = "8.0.21"
}

variable "private_dns_zone_virtual_network_link_name" {
  default = "mysqlfsVnetZoned1base.com"
}

variable "sku_name" {
  default = "B_Standard_B1s"
}

variable "mysql_zone" {
  default = "2"
}