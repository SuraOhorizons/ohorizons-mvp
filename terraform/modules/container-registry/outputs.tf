output "id" {
  description = "Container Registry ID"
  value = var.use_existing_container_registry ? (
    data.azurerm_container_registry.existing[0].id
  ) : azurerm_container_registry.main[0].id
}

output "name" {
  description = "Container Registry name"
  value = var.use_existing_container_registry ? (
    data.azurerm_container_registry.existing[0].name
  ) : azurerm_container_registry.main[0].name
}

output "login_server" {
  description = "Container Registry login server"
  value = var.use_existing_container_registry ? (
    data.azurerm_container_registry.existing[0].login_server
  ) : azurerm_container_registry.main[0].login_server
}

output "admin_username" {
  description = "Container Registry admin username (if enabled)"
  value = var.use_existing_container_registry ? (
    data.azurerm_container_registry.existing[0].admin_username
  ) : azurerm_container_registry.main[0].admin_username
  sensitive = true
}

output "identity_principal_id" {
  description = "Container Registry managed identity principal ID. Null when using an existing ACR."
  value = var.use_existing_container_registry ? null : (
    azurerm_container_registry.main[0].identity[0].principal_id
  )
}

output "private_endpoint_ip" {
  description = "Container Registry private endpoint IP address"
  value = var.use_existing_container_registry ? null : (
    azurerm_private_endpoint.acr[0].private_service_connection[0].private_ip_address
  )
}

output "scope_map_ids" {
  description = "Scope map IDs for token creation"
  value = var.use_existing_container_registry ? {} : {
    ci_push  = azurerm_container_registry_scope_map.ci_push[0].id
    readonly = azurerm_container_registry_scope_map.readonly[0].id
  }
}
