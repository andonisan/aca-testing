data "azapi_resource" "aca_env" {
  type      = "Microsoft.App/managedEnvironments@2022-03-01"
  name      = local.aca_name
  parent_id = data.azurerm_resource_group.rg.id
}

resource "azapi_resource" "containerapp" {
  type      = "Microsoft.App/containerapps@2022-03-01"
  name      = local.feature_name
  parent_id = data.azurerm_resource_group.rg.id
  location  = data.azurerm_resource_group.rg.location

  body = jsonencode({
    properties = {
      managedEnvironmentId = data.azapi_resource.aca_env.id
      configuration        = {
        ingress = {
          external : true,
          targetPort : 80
        },
        registries = [
          {
            server            = data.azurerm_container_registry.acr.login_server
            username          = data.azurerm_container_registry.acr.admin_username
            passwordSecretRef = "registry-password"
          }
        ],
        secrets : [
          {
            name = "registry-password"
            value = data.azurerm_container_registry.acr.admin_password
          }
        ]
      }
      template = {
        containers = [
          {
            image     = var.image_name
            name      = var.app_name
            resources = {
              cpu    = 0.25
              memory = "0.5Gi"
            }
          }
        ]
        scale = {
          minReplicas = 0,
          maxReplicas = 2
        }
      }
    }

  })
}