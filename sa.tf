#####################################
# STORAGE ACCOUNT (Azure Files cho MinIO)
#####################################
resource "azurerm_storage_account" "sa" {
  # storage account name: 3–24 ký tự, chỉ a-z0-9, phải unique toàn cầu
  name                     = "st${local.suffix}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_share" "minio_share" {
  name               = "minio-data"
  storage_account_id = azurerm_storage_account.sa.id
  quota              = 50 # GB
}