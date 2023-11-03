output "storage_account_id" {
  description = "The ID of the storage account."
  value       = azurerm_storage_account.fileacc.id
}

output "storage_account_name" {
  description = "The name of the storage account."
  value       = azurerm_storage_account.fileacc.name
}

output "storage_account_primary_location" {
  description = "The primary location of the storage account"
  value       = azurerm_storage_account.fileacc.primary_location
}

output "storage_account_primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary location."
  value       = azurerm_storage_account.fileacc.primary_blob_endpoint
}

output "storage_account_primary_web_endpoint" {
  description = "The endpoint URL for web storage in the primary location."
  value       = azurerm_storage_account.fileacc.primary_web_endpoint
}

output "storage_account_primary_web_host" {
  description = "The hostname with port if applicable for web storage in the primary location."
  value       = azurerm_storage_account.fileacc.primary_web_host
}

output "storage_primary_connection_string" {
  description = "The primary connection string for the storage account"
  value       = azurerm_storage_account.fileacc.primary_connection_string
  sensitive   = true
}

output "storage_primary_access_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.fileacc.primary_access_key
  sensitive   = true
}

output "storage_secondary_access_key" {
  description = "The primary access key for the storage account."
  value       = azurerm_storage_account.fileacc.secondary_access_key
  sensitive   = true
}


#output "file_shares" {
#  description = "Map of Storage SMB file shares."
#  value       = { for f in azurerm_storage_share.fileshare : f.name => f.id }
#}
