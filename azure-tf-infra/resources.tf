######################################################################
###
###       PROVIDER DEFINITIONS
###
######################################################################
provider "azurerm" {
  version = ">= 2.3.0"
  features {}
}

######################################################################
###
###       RESOURCES
###
######################################################################

resource "azurerm_resource_group" "rg" {
  name                      = var.resource_group_name
  location                  = var.region
}

resource "azurerm_storage_account" "storage" {
  name                      = var.storage_account_name
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  static_website {
    index_document          = var.index_document
  }
}

resource "azurerm_application_insights" "appinsights" {
  name                      = var.appinsights_name
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  application_type          = var.application_type
}