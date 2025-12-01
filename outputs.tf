output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "postgres_connection_string" {
  value     = "postgresql://${var.db_admin_login}:${var.db_admin_password}@${azurerm_postgresql_flexible_server.db.fqdn}:5432/${var.db_name}?sslmode=require"
  sensitive = true
}
output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}