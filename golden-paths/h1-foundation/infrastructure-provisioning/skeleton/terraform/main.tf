# =============================================================================
# ${{values.name}} - Infrastructure
# =============================================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
  }

  backend "azurerm" {
    resource_group_name  = "${{values.resource_group_name}}"
    storage_account_name = "sttfstate${{values.customer}}"
    container_name       = "tfstate"
    key                  = "${{values.name}}-${{values.environment}}.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# -----------------------------------------------------------------------------
# Resource Group
# -----------------------------------------------------------------------------

resource "azurerm_resource_group" "main" {
  name     = "rg-${{values.name}}-${var.environment}"
  location = var.location

  tags = var.tags
}

# -----------------------------------------------------------------------------
# Add your resources here
# -----------------------------------------------------------------------------
