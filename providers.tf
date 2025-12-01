terraform {
  required_version = ">= 1.5.0"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.40.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Kết nối trực tiếp tới AKS do azurerm_kubernetes_cluster tạo ra
provider "kubectl" {
  host                   = azurerm_kubernetes_cluster.aks.kube_config[0].host
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate)
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_key)

  # có thể thêm:
  load_config_file       = false
}
