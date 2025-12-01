
#####################################
# STORAGE ACCOUNT (Azure Files)
#####################################
resource "azurerm_storage_account" "sa" {
  name                     = "st${local.suffix}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_share" "minio_share" {
  name                 = "minio-data"
  storage_account_id   = azurerm_storage_account.sa.id
  quota                = 100
}