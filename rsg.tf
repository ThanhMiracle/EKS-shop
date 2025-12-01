#####################################
# RANDOM SUFFIX
#####################################
resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

locals {
  suffix = random_string.suffix.result
}

#####################################
# RESOURCE GROUP
#####################################
resource "azurerm_resource_group" "rg" {
  name     = "${var.project_name}-rg-${local.suffix}"
  location = var.location
}