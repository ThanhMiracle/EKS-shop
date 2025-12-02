########################################
# AKS Outputs
########################################

output "aks_name" {
  description = "Tên của AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "resource_group_name" {
  description = "Tên Resource Group chứa AKS và các resource liên quan"
  value       = azurerm_resource_group.rg.name
}

# Kubeconfig user (dùng để kubectl)
output "kube_config_raw" {
  description = "Kubeconfig dành cho user (kubectl access)"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

# Admin kubeconfig (quyền cao nhất)
output "kube_admin_config_raw" {
  description = "Admin kubeconfig của AKS (full cluster access)"
  value       = azurerm_kubernetes_cluster.aks.kube_admin_config_raw
  sensitive   = true
}

########################################
# Database Outputs
########################################

output "postgres_connection_string" {
  description = "Connection string để ứng dụng kết nối PostgreSQL"
  value       = "postgresql://${var.db_admin_login}:${var.db_admin_password}@${azurerm_postgresql_flexible_server.db.fqdn}:5432/${var.db_name}?sslmode=require"
  sensitive   = true
}

########################################
# Storage Outputs
########################################

output "storage_account_name" {
  description = "Tên Storage Account dùng cho Azure Files"
  value       = azurerm_storage_account.sa.name
}

output "storage_account_key" {
  description = "Access key của Storage Account"
  value       = azurerm_storage_account.sa.primary_access_key
  sensitive   = true
}

output "azure_file_share_name" {
  description = "Tên Azure Files share dùng cho MinIO PV/PVC"
  value       = azurerm_storage_share.minio_share.name
}
