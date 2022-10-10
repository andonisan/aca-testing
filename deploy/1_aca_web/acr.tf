data "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = data.azurerm_resource_group.rg.name

}