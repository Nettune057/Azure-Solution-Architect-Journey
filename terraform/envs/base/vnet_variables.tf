variable "address_space" {
  default = ["10.0.0.0/16"]
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

variable "subnet" {
  type = list(any)
  default = [
    {
    subnet_name = "d1-base-AppGw-subnet"
    address_prefixes = ["10.0.0.0/24"]
    },
    {
    subnet_name = "d1-base-database-subnet"
    address_prefixes = ["10.0.1.0/24"]
    },
    {
    subnet_name = "d1-base-server-subnet"
    address_prefixes = ["10.0.2.0/24"]
    }
  ]
}

variable "pip" {
  type = list(any)
  default = [
    {
      pip_name = "d1-base-AppGw-pip"
      allocation_method = "Static"
      az = ["1"]
    },
    {
      pip_name = "d1-base-NAT-pip"
      allocation_method = "Static"
      az = ["1"]
    },
    {
      pip_name = "d1-base-bastion-pip"
      allocation_method = "Static"
      az = ["1"]
    }
  ]
}
variable "nat" {
  type = list(any)
  default = [
    {
      nat_name = "d1-base-NAT"
      sku      = "Standard"
      az       = ["1"]
    }
  ]
}
