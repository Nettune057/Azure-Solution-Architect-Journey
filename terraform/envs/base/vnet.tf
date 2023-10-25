module "vnet" {
  source                    = "../../modules/terraform-azure-network"
  address_space             = var.address_space
  bgp_community             = var.bgp_community
  ddos_protection_plan      = var.ddos_protection_plan
  dns_servers               = var.dns_servers
  resource_group_name       = local.rg_name
  tags                      = local.tags
  vnet_location             = local.rg_location
  vnet_name                 = "${local.prefix_name}-${var.vnet_name}"
  subnet                    = var.subnet
  pip                       = var.pip
  nat                       = var.nat
}