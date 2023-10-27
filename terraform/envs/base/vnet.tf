module "vnet" {
  source                    = "../../modules/terraform-azure-network"
  address_space             = ["${var.address_space}"]
  bgp_community             = var.bgp_community
  ddos_protection_plan      = var.ddos_protection_plan
  dns_servers               = var.dns_servers
  resource_group_name       = local.rg_name
  tags                      = local.tags
  vnet_location             = local.rg_location
  vnet_name                 = "${local.prefix_name}-${var.vnet_name}"
  natpip                    = [
    {
      natpip_name = "${local.prefix_name}-${var.NAT-IP}"
      allocation_method = var.allocation_method == true ? "Static" : "Dynamic"
      az = var.az
    }
  ]
  pip                       = [
    {
      pip_name = "${local.prefix_name}-${var.AppGw-IP}"
      allocation_method = var.allocation_method == true ? "Static" : "Dynamic"
      az = var.az
    },
    {
      pip_name = "${local.prefix_name}-${var.bastion-IP}"
      allocation_method = var.allocation_method == true ? "Static" : "Dynamic"
      az = var.az
    }
  ]
  nat                       = [
    {
      nat_name = "${local.prefix_name}-${var.nat_name}"
      sku      = var.sku
      az       = var.az
    }
  ]
  address_prefixes_appgw    = [cidrsubnet(var.address_space,8 ,1 )]
  address_prefixes_bastion  = [cidrsubnet(var.address_space,8 ,2 )]
  address_prefixes_database = [cidrsubnet(var.address_space,8 ,3 )]
  address_prefixes_server   = [cidrsubnet(var.address_space,8 ,4 )]
  appgw_subnet_name         = "${local.prefix_name}-${var.appgw_name}"
  bastion_subnet_name       = "${local.prefix_name}-${var.bastion_name}"
  database_subnet_name      = "${local.prefix_name}-${var.database_name}"
  server_subnet_name        = "${local.prefix_name}-${var.server_name}"
  location                  = ""
  nsg                       = "${local.prefix_name}-${var.nsg}"
  inbound_rules = [
    {
      name                       = "inbound_rule_1"
      priority                   = 100
      access                     = "Allow"
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
      description                = "inbound_rule_1"
    },
    {
      name                   = "inbound_rule_2"
      priority               = 200
      access                 = "Deny"
      protocol               = "Udp"
      source_address_prefix  = "*"
      destination_port_range = 22
      description            = "inbound_rule_2"
    }
  ]
  outbound_rules = []
}