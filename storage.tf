# implicit dependency
resource"azurerm_storage_account""sg_storage"{
    name ="storageaccount0008"
    resource_group_name = azurerm_resource_group.rg_dev.name
    location = "East US"
    account_tier ="Standard"
    account_replication_type ="LRS"
}