# =============================================================================
# OPEN HORIZONS PLATFORM - STORAGE MODULE
# =============================================================================
#
# Supports:
#   - Existing Azure Storage Accounts
#   - New Storage Account creation when no existing account is supplied
#
# =============================================================================

locals {
  name_prefix = "${var.customer_name}${var.environment}"

  storage_account_name = replace(
    "st${local.name_prefix}",
    "-",
    ""
  )

  common_tags = merge(var.tags, {
    "open-horizons-customer"    = var.customer_name
    "open-horizons-environment" = var.environment
    "open-horizons-component"   = "storage"
  })
}

# =============================================================================
# EXISTING STORAGE ACCOUNTS
# =============================================================================

data "azurerm_storage_account" "existing" {
  for_each = toset(var.existing_storage_account_names)

  name                = each.value
  resource_group_name = var.resource_group_name
}

# =============================================================================
# STORAGE ACCOUNT
# =============================================================================

resource "azurerm_storage_account" "main" {
  count = length(var.existing_storage_account_names) == 0 ? 1 : 0

  name                     = local.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version = "TLS1_2"

  public_network_access_enabled = false

  allow_nested_items_to_be_public = false

  tags = local.common_tags
}
