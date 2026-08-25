output "vnet_id" {
  description = "Virtual Network ID"
  value       = var.use_existing_network ? data.azurerm_virtual_network.existing[0].id : azurerm_virtual_network.main[0].id
}

output "vnet_name" {
  description = "Virtual Network name"
  value       = var.use_existing_network ? data.azurerm_virtual_network.existing[0].name : azurerm_virtual_network.main[0].name
}

output "subnet_ids" {
  description = "Subnet IDs"
  value = var.use_existing_network ? {
    aks_nodes         = var.existing_subnet_ids["aks_nodes"]
    aks_pods          = var.existing_subnet_ids["aks_pods"]
    postgres          = var.existing_subnet_ids["postgres"]
    private_endpoints = var.existing_subnet_ids["private_endpoints"]
    } : {
    aks_nodes         = azurerm_subnet.aks_nodes[0].id
    aks_pods          = azurerm_subnet.aks_pods[0].id
    postgres          = azurerm_subnet.postgres[0].id
    private_endpoints = azurerm_subnet.private_endpoints[0].id
  }
}

output "aks_subnet_id" {
  description = "AKS nodes subnet ID"
  value       = var.use_existing_network ? var.existing_subnet_ids["aks_nodes"] : azurerm_subnet.aks_nodes[0].id
}

output "private_dns_zone_ids" {
  description = "Private DNS zone IDs"
  value = var.use_existing_network ? var.existing_private_dns_zone_ids : merge({
    for key, zone in azurerm_private_dns_zone.zones : key => zone.id
    }, {
    eventhub = azurerm_private_dns_zone.zones["servicebus"].id
  })
}

output "private_dns_zone_names" {
  description = "Private DNS zone names"
  value = var.use_existing_network ? {} : merge({
    for key, zone in azurerm_private_dns_zone.zones : key => zone.name
    }, {
    eventhub = azurerm_private_dns_zone.zones["servicebus"].name
  })
}

output "public_dns_zone_id" {
  description = "Public DNS zone ID"
  value       = var.create_dns_zone ? azurerm_dns_zone.public[0].id : null
}

output "public_dns_zone_name_servers" {
  description = "DNS name servers"
  value       = var.create_dns_zone ? azurerm_dns_zone.public[0].name_servers : null
}

output "bastion_hostname" {
  description = "Azure Bastion hostname"
  value       = var.enable_bastion ? azurerm_bastion_host.main[0].dns_name : null
}

output "nsg_ids" {
  description = "Network Security Group IDs"
  value = var.use_existing_network ? {} : {
    aks_nodes         = azurerm_network_security_group.aks_nodes[0].id
    private_endpoints = azurerm_network_security_group.private_endpoints[0].id
  }
}
