variable "address_space" {}
variable "vnet_location" {}
variable "vnet_name" {}
variable "resource_group_name" {}
variable "bgp_community" {}
variable "dns_servers" {}
variable "tags" {}
variable "ddos_protection_plan" {}
variable "create_nsg" {
  default = true
}
variable "nsg" {}
variable "address_prefixes_appgw" {}
variable appgw_subnet_name {}

variable "server_subnet_name" {}
variable "address_prefixes_server" {}

variable "bastion_subnet_name" {}
variable "address_prefixes_bastion" {}

variable "address_prefixes_database" {}
variable "database_subnet_name" {}


variable "create_subnet" {
  default = true
}

variable "pip" {}
variable "natpip" {}
variable "create_public_ip" {
  default = true
}
variable "SKU" {
  default = "Standard"
}
variable "create_NAT" {
  default = true
}
variable "nat" {}

variable "predefined_rules" {
  type        = any
  default     = []
  description = "Predefined rules"
}

