﻿resource "azurerm_storage_account" "sa" {
  name                     = local.sa_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = local.tags
}

resource "azurerm_storage_container" "example" {
  name                  = "terraformgithubexample"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}