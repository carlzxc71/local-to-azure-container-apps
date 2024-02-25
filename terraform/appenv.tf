resource "azurerm_container_app_environment" "this" {
  name                       = var.container_app_env_name
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
}

resource "azapi_resource" "app" {
  type      = "Microsoft.App/jobs@2023-05-01"
  name      = var.container_app_job_name
  parent_id = azurerm_resource_group.this.id

  body = jsonencode({
    location = azurerm_resource_group.this.location
    properties = {
      environmentId = azurerm_container_app_environment.this.id
      configuration = {
        scheduleTriggerConfig = null
        replicaRetryLimit     = 1
        replicaTimeout        = 1800
        triggerType           = "Manual"
        secrets               = null
      }
      template = {
        containers = [
          {
            name  = "${var.container_app_job_name}",
            image = "docker.io/altinlab/xenitqr:azqr0.52.0"
            resources = {
              cpu    = 0.25
              memory = "0.5Gi"
            }
            env = [
              {
                "name" : "STORAGE_ACCOUNT",
                "value" : "${var.st_account_name}"
              },
              {
                "name" : "APPSETTING_WEBSITE_SITE_NAME", ## Required environment variable as MI fails to contact the correct endpoint without it
                "value" : "DUMMY"
              }
            ]
          }
        ]
      }
    }
    identity = {
      type = "SystemAssigned"
    }
  })
}
