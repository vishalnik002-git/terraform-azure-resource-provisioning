output "resource_group_name" {
  description = "Name of the created Resource Group."
  value       = azurerm_resource_group.rg.name
}

output "storage_account_id" {
  description = "The Resource ID of the provisioned Storage Account."
  value       = azurerm_storage_account.sa.id
}

output "storage_account_name" {
  description = "The Name of the provisioned Storage Account."
  value       = azurerm_storage_account.sa.name
}

output "primary_blob_endpoint" {
  description = "The primary blob service endpoint URL."
  value       = azurerm_storage_account.sa.primary_blob_endpoint
}
