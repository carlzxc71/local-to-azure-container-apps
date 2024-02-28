data "azurerm_subscription" "primary" {
}

resource "azurerm_role_assignment" "owner" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Owner"
  principal_id         = azapi_resource.app.identity[0].principal_id
}
