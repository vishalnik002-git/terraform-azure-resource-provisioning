# 1. Resource Group Provisioning
# Required properties: name, location
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# 2. Storage Account Provisioning
# Required properties: name, resource_group_name, location, account_tier, account_replication_type
# Referencing azurerm_resource_group.rg.name creates an implicit dependency,
# ensuring Terraform creates the Resource Group before attempting to create the Storage Account.
resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}
