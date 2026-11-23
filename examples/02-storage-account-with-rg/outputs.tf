output "storage_endpoint" {
  value = azurerm_storage_account.child_sa.primary_blob_endpoint
}
