#####################################
# AZURE POSTGRESQL
#####################################
resource "azurerm_postgresql_flexible_server" "db" {
  name                   = "${var.project_name}-pg-${local.suffix}"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  version                = "16"
  administrator_login    = var.db_admin_login
  administrator_password = var.db_admin_password
  sku_name               = "B_Standard_B1ms"
  storage_mb             = 32768
  authentication {
    password_auth_enabled = true
  }
  public_network_access_enabled = true
}

resource "azurerm_postgresql_flexible_server_database" "db_app" {
  name      = var.db_name
  server_id = azurerm_postgresql_flexible_server.db.id
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "allow_all" {
  name             = "allow-all"
  server_id        = azurerm_postgresql_flexible_server.db.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}
