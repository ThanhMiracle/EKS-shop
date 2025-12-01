locals {
  database_url = "postgresql://${var.db_admin_login}:${var.db_admin_password}@${azurerm_postgresql_flexible_server.db.fqdn}:5432/${var.db_name}?sslmode=require"
}

# 1. Namespace
resource "kubectl_manifest" "namespace" {
  yaml_body = file("${var.path_module}/namespace.yaml")
  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}

# 2. ConfigMap (FE)
resource "kubectl_manifest" "configmap" {
  yaml_body = file("${var.path_module}/configmap.yaml")
  depends_on = [
    kubectl_manifest.namespace
  ]
}

# 3. Secrets

# app-secrets (DATABASE_URL + JWT)
resource "kubectl_manifest" "app_secrets" {
  yaml_body = templatefile("${var.path_module}/app-secrets.yaml", {
    database_url       = local.database_url
    jwt_secret         = var.jwt_secret
    jwt_expire_minutes = var.jwt_expire_minutes
  })

  depends_on = [
    kubectl_manifest.namespace
  ]
}

# minio-secret
resource "kubectl_manifest" "minio_secret" {
  yaml_body = file("${var.path_module}/minio-secret.yaml")
  depends_on = [
    kubectl_manifest.namespace
  ]
}

# 4. PVC cho MinIO
resource "kubectl_manifest" "minio_pvc" {
  yaml_body = file("${var.path_module}/minio-pvc.yaml")
  depends_on = [
    kubectl_manifest.namespace
  ]
}

# 5. MinIO (phụ thuộc PVC + secret)
resource "kubectl_manifest" "minio" {
  yaml_body = file("${var.path_module}/minio-deploy-svc.yaml")
  depends_on = [
    kubectl_manifest.namespace,
    kubectl_manifest.minio_pvc,
    kubectl_manifest.minio_secret
  ]
}

# 6. API (phụ thuộc secrets + MinIO)
resource "kubectl_manifest" "api" {
  yaml_body = file("${var.path_module}/api-deploy-svc.yaml")
  depends_on = [
    kubectl_manifest.namespace,
    kubectl_manifest.app_secrets,
    kubectl_manifest.minio
  ]
}

# 7. Frontend (phụ thuộc API + configmap)
resource "kubectl_manifest" "frontend" {
  yaml_body = file("${var.path_module}/frontend-deploy-svc.yaml")
  depends_on = [
    kubectl_manifest.namespace,
    kubectl_manifest.configmap,
    kubectl_manifest.api
  ]
}

# 8. Ingress (phụ thuộc FE + API)
resource "kubectl_manifest" "ingress" {
  yaml_body = file("${var.path_module}/ingress.yaml")
  depends_on = [
    kubectl_manifest.frontend,
    kubectl_manifest.api
  ]
}

# 9. Worker (mount PVC)
resource "kubectl_manifest" "worker" {
  yaml_body = file("${var.path_module}/worker-mount.yaml")
  depends_on = [
    kubectl_manifest.namespace,
    kubectl_manifest.minio_pvc
  ]
}
