######################################################################
###
###       OUTPUTS
###
######################################################################
output "INSTRUMENTATION_KEY" {
  value = nonsensitive("${azurerm_application_insights.appinsights.instrumentation_key}")
}

output "AZURE_STORAGE_CONNECTION_STRING" {
  value = nonsensitive("${azurerm_storage_account.storage.primary_connection_string}")
}

output "WEBSITE" {
  value = azurerm_storage_account.storage.primary_web_endpoint
}
