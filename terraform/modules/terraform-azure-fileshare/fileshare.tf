resource "azurerm_storage_share" "fileshare" {
  count                = length(var.file_shares)
  name                 = var.file_shares[count.index].name
  storage_account_name = azurerm_storage_account.fileacc.name
  quota                = var.file_shares[count.index].quota
  depends_on = [azurerm_storage_account.fileacc]
}
