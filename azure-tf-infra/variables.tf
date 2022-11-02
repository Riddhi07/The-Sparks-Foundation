######################################################################
###
###       INPUT VARIABLES
###
######################################################################
variable "region" {
  type = string
  default = "eastus2"
  description = "The Azure region used for resources"
}
variable "resource_group_name" {
  type = string
  default = "kloudjet-angular-rg"
  description = "The name of the resource group"
}
variable "storage_account_name" {
  type = string
  default = "kloudjetangularstorage01"
  description = "The name of the storage account"
}
variable "account_kind" {
  type = string
  default = "StorageV2"
  description = "Each type supports different features and has its own pricing model."
}
variable "account_tier" {
  type = string
  default = "Standard"
  description = "Storage account tier - Basic, Standard or Premium"
}
variable "account_replication_type" {
  type = string
  default = "LRS"
  description = "How your data is replicated in the primary region"
}
variable "index_document" {
  type = string
  default = "index.html"
  description = "Static website where application will start"
}
variable "appinsights_name" {
  type = string
  default = "kloudjet-azure-angular"
  description = "The name for the application insights"
}
variable "application_type" {
  type = string
  default = "web"
  description = "The type of application"
}