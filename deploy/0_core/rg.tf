resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = local.tags
}

