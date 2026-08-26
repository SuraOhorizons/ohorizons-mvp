# =============================================================================
# OPEN HORIZONS PLATFORM - STORAGE MODULE OUTPUTS
# =============================================================================

output "storage_account_names" {
  description = "Storage Account names available to the platform"
  value = length(var.existing_storage_account_names) > 0 ? (
    var.existing_storage_account_names
    ) : [
    azurerm_storage_account.main[0].name
  ]
}

output "storage_account_ids" {
  description = "Storage Account resource IDs"
  value = length(var.existing_storage_account_names) > 0 ? (
    [for name in var.existing_storage_account_names : data.azurerm_storage_account.existing[name].id]
    ) : [
    azurerm_storage_account.main[0].id
  ]
}

output "storage_account_blob_endpoints" {
  description = "Primary Blob endpoints"
  value = length(var.existing_storage_account_names) > 0 ? (
    [for name in var.existing_storage_account_names : data.azurerm_storage_account.existing[name].primary_blob_endpoint]
    ) : [
    azurerm_storage_account.main[0].primary_blob_endpoint
  ]
}
