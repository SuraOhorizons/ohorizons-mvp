# =============================================================================
# OPEN HORIZONS PLATFORM - STORAGE MODULE VARIABLES
# =============================================================================

variable "customer_name" {
  description = "Customer name for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the Storage Accounts"
  type        = string
}

variable "existing_storage_account_names" {
  description = "Existing Azure Storage Account names. When populated, no Storage Account is created."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply to newly created resources"
  type        = map(string)
  default     = {}
}
