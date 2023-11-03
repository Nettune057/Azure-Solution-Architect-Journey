module "fileshare" {
  source  = "../../modules/terraform-azure-fileshare"
  resource_group_name   = local.rg_name
  location              = local.rg_location
  storage_account_name  = "${var.setup_name}${var.env}${var.fileshare_stoacc_name}"

  file_shares = [
    { name = "${local.prefix_name}-${var.fileshare}", quota = var.quota }
  ]

  network_rules = {
    ip_rules = var.ip_rules
    bypass = var.bypass
    subnet_ids = [module.vnet.server_subnet]
  }

  tags = local.tags
}
