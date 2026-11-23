resource "azurerm_resource_group" "parent_rg" {
  name     = "rg-storage-demo"
  location = "eastus"
}

resource "azurerm_storage_account" "child_sa" {
  name                     = "stexamplerelation01"
  resource_group_name      = azurerm_resource_group.parent_rg.name
  location                 = azurerm_resource_group.parent_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
