module "static-website-cdn" {
  source  = "../../modules/terraform-azure-storage-account/"

  sku                   = var.storacc_sku
  account_kind          = var.account_kind

  location              = var.rg_location
  storage_account_name  = "${var.setup_name}${var.env}frontendstoracc"
  cdn_profile_name      = "${local.prefix_name}-${var.cdn_profile_name}"


  resource_group_name         = "${local.prefix_name}-${var.rg_name}"
  static_website_source_folder = var.static_website_source_folder
  index_path                   = var.index_path
  custom_404_path              = var.custom_404_path
  allowed_origins              = ["https://${local.prefix_name}-${var.cdn_profile_name}.azureedge.net"]

  enable_cdn_profile = var.enable_cdn_profile
  cdn_sku_profile    = var.cdn_sku_profile

  tags = local.tags
}
