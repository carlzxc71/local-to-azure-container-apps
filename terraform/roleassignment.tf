data "azurerm_subscription" "primary" {
}

resource "azurerm_role_assignment" "reader" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Reader"
  principal_id         = azapi_resource.app.identity[0].principal_id
}

resource "azurerm_role_assignment" "st_account_contributor" {
  scope                = azurerm_storage_account.this.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = azapi_resource.app.identity[0].principal_id
}
