# =============================================================================
# OPEN HORIZONS PLATFORM - NETWORKING MODULE VARIABLES
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
  description = "Resource group name"
  type        = string
}

variable "vnet_cidr" {
  description = "CIDR block for VNet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_config" {
  description = "Subnet configuration"
  type = object({
    aks_nodes_cidr         = string
    aks_pods_cidr          = string
    postgres_cidr          = string
    private_endpoints_cidr = string
    bastion_cidr           = string
    app_gateway_cidr       = string
  })
  default = {
    aks_nodes_cidr         = "10.0.0.0/22"
    aks_pods_cidr          = "10.0.16.0/20"
    postgres_cidr          = "10.0.7.0/24"
    private_endpoints_cidr = "10.0.4.0/24"
    bastion_cidr           = "10.0.5.0/26"
    app_gateway_cidr       = "10.0.6.0/24"
  }
}

variable "enable_bastion" {
  description = "Enable Azure Bastion for secure VM access"
  type        = bool
  default     = false
}

variable "enable_app_gateway" {
  description = "Enable Application Gateway subnet"
  type        = bool
  default     = false
}

variable "dns_zone_name" {
  description = "Public DNS zone name"
  type        = string
}

variable "create_dns_zone" {
  description = "Create the public DNS zone"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "use_existing_network" {
  description = "Use an existing Azure VNet and subnets."
  type        = bool
  default     = false
}

variable "existing_vnet_name" {
  description = "Existing Azure VNet name."
  type        = string
  default     = ""
}

variable "existing_subnet_names" {
  description = "Existing subnet names keyed by platform purpose."
  type        = map(string)
  default     = {}
}

variable "existing_private_dns_zone_ids" {
  description = "Existing Private DNS Zone IDs keyed by service."
  type        = map(string)
  default     = {}
}
