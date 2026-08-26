output "key_vault_id" {
  description = "Key Vault ID"
  value       = local.key_vault_id
}

output "key_vault_name" {
  description = "Key Vault name"
  value       = local.key_vault_name
}

output "key_vault_uri" {
  description = "Key Vault URI"
  value       = local.key_vault_uri
}

output "keyvault_name" {
  description = "Key Vault name (alias)"
  value       = local.key_vault_name
}

output "keyvault_uri" {
  description = "Key Vault URI (alias)"
  value       = local.key_vault_uri
}

output "workload_identity_client_ids" {
  description = "Workload identity client IDs"
  value = {
    for name, identity in azurerm_user_assigned_identity.workload : name => identity.client_id
  }
}

output "workload_identity_principal_ids" {
  description = "Workload identity principal IDs"
  value = {
    for name, identity in azurerm_user_assigned_identity.workload : name => identity.principal_id
  }
}

output "external_secrets_client_id" {
  description = "External Secrets Operator client ID"
  value       = azurerm_user_assigned_identity.external_secrets.client_id
}

output "aad_application_id" {
  description = "Azure AD application ID for SSO"
  value       = length(azuread_application.github_sso) > 0 ? azuread_application.github_sso[0].client_id : null
}

output "aad_tenant_id" {
  description = "Azure AD tenant ID"
  value       = var.tenant_id
}

output "private_endpoint_ip" {
  description = "Key Vault private endpoint IP"
  value = var.use_existing_key_vault ? null : (
    azurerm_private_endpoint.key_vault[0].private_service_connection[0].private_ip_address
  )
}
