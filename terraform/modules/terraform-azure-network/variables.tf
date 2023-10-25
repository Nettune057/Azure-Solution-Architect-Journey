variable "address_space" {}
variable "vnet_location" {}
variable "vnet_name" {}
variable "resource_group_name" {}
variable "bgp_community" {}
variable "dns_servers" {}
variable "tags" {}
variable "ddos_protection_plan" {}
variable "create_subnet" {
  default = true
}
variable "subnet" {}
variable "pip" {}
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
