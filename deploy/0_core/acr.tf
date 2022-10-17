resource "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
  tags                = local.tags
}

resource "azurerm_container_registry_task" "purge" {
  name                  = "${local.acr_name}PurgeTask"
  container_registry_id = azurerm_container_registry.acr.id
  platform {
    os           = "Linux"
    architecture = "amd64"
  }
  encoded_step {
    task_content = <<EOF
version: v1.1.0
steps: 
  - cmd: acr purge  --filter "web:.*" --ago 7d --untagged
    disableWorkingDirectoryOverride: true
    timeout: 3600
EOF
  }
  agent_setting {
    cpu = 2
  }
  base_image_trigger {
    name                        = "defaultBaseimageTriggerName"
    type                        = "Runtime"
    enabled                     = true
    update_trigger_payload_type = "Default"
  }
  timer_trigger {
    name     = "t1"
    schedule = "0 1 * * Sun"
    enabled  = true
  }
}
