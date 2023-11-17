variable "address_space" {
  default = "10.0.0.0/16"
}
variable "bgp_community" {
  default = null
}
variable "ddos_protection_plan" {
  default = null
}

variable "dns_servers" {
  default = null
}
variable "vnet_name" {
  default = "vnet"
}

variable "appgw_name" {
  default = "appgw-subnet"
}

variable "server_name" {
  default = "server-subnet"
}

variable "database_name" {
  default = "database-subnet"
}

variable "bastion_name" {
  default = "bastion-subnet"
}



variable "allocation_method"{
  type    = bool
  default = true
}

variable "az" {
  default = ["1"]
}

variable "nsg" {
  default = "nsg"
}

variable "AppGw-IP" {
  default = "AppGw-pip"
}
variable "NAT-IP" {
  default = "NAT-pip"
}
variable "bastion-IP" {
  default = "bastion-pip"
}

variable "nat_name" {
  default = "NAT"
}

variable "sku" {
  default = "Standard"
}
