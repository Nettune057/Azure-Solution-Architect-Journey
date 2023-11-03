#---------------------------------------------------------
# Local declarations
#----------------------------------------------------------

#-------------------------------------------------------------
# Resource Group Creation or selection - Default is "false"
#-------------------------------------------------------------
resource "azurerm_resource_group" "rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
  tags     = merge({ "Name" = format("%s", var.resource_group_name) }, var.tags, )
}

#---------------------------------------------------------
# Storage Account Creation and enable static website
#----------------------------------------------------------
resource "azurerm_storage_account" "storeacc" {
  name                      = var.storage_account_name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_kind              = var.account_kind
  account_tier              = local.account_tier
  account_replication_type  = local.account_replication_type
  enable_https_traffic_only = var.enable_https_traffic
  tags                      = merge({ "Name" = format("%s", var.storage_account_name) }, var.tags, )

  dynamic "static_website" {
    for_each = local.if_static_website_enabled
    content {
      index_document     = var.index_path
      error_404_document = var.custom_404_path
    }
  }
  dynamic "blob_properties" {
    for_each = local.if_static_website_enabled
    content {
      cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["GET","HEAD","POST","PUT"]
        allowed_origins = var.allowed_origins
        exposed_headers = ["*"]
        max_age_in_seconds = 3600
      }
    }
  }

  identity {
    type = var.assign_identity ? "SystemAssigned" : null
  }
  depends_on = [ azurerm_resource_group.rg ]
}

## Following resource is not removed when we update the terraform plan with `false` after initial run. Need to check for the option to remove `$web` folder if we disable static website and update the plan.
#resource "null_resource" "copyfilesweb" {
#  count = var.enable_static_website ? 1 : 0
#  provisioner "local-exec" {
#    command = "az storage blob upload-batch --no-progress --account-name ${azurerm_storage_account.storeacc.name} --account-key ${azurerm_storage_account.storeacc.primary_access_key}  -s ${var.static_website_source_folder} -d '$web' --output none"
#  }
#}



