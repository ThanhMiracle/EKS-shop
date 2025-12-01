#####################################
# AKS
#####################################
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.project_name}-aks-${local.suffix}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.project_name}-dns-${local.suffix}"

  default_node_pool {
    name       = "system"
    node_count = var.aks_node_count
    vm_size    = var.aks_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    #sku            = "Standard"
  }

  role_based_access_control_enabled = true
}