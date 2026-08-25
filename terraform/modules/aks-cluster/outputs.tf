output "cluster_id" {
  description = "AKS cluster ID"
  value       = local.effective_cluster_id
}

output "cluster_name" {
  description = "AKS cluster name"
  value       = local.effective_cluster_name
}

output "cluster_fqdn" {
  description = "AKS cluster FQDN"
  value       = local.effective_cluster_fqdn
}

output "host" {
  description = "Kubernetes API server host"
  value = var.use_existing_aks ? (
    data.azurerm_kubernetes_cluster.existing[0].kube_config[0].host
  ) : azurerm_kubernetes_cluster.main[0].kube_config[0].host
  sensitive = true
}

output "cluster_ca_certificate" {
  description = "Kubernetes cluster CA certificate"
  value = var.use_existing_aks ? (
    base64decode(data.azurerm_kubernetes_cluster.existing[0].kube_config[0].cluster_ca_certificate)
  ) : base64decode(azurerm_kubernetes_cluster.main[0].kube_config[0].cluster_ca_certificate)
  sensitive = true
}

output "client_certificate" {
  description = "Kubernetes client certificate"
  value = var.use_existing_aks ? (
    base64decode(data.azurerm_kubernetes_cluster.existing[0].kube_config[0].client_certificate)
  ) : base64decode(azurerm_kubernetes_cluster.main[0].kube_config[0].client_certificate)
  sensitive = true
}

output "client_key" {
  description = "Kubernetes client key"
  value = var.use_existing_aks ? (
    base64decode(data.azurerm_kubernetes_cluster.existing[0].kube_config[0].client_key)
  ) : base64decode(azurerm_kubernetes_cluster.main[0].kube_config[0].client_key)
  sensitive = true
}

output "kube_config" {
  description = "Kubernetes config (for kubectl)"
  value = var.use_existing_aks ? (
    data.azurerm_kubernetes_cluster.existing[0].kube_config_raw
  ) : azurerm_kubernetes_cluster.main[0].kube_config_raw
  sensitive = true
}

output "admin_host" {
  description = "Kubernetes API server host from admin kubeconfig"
  value = var.use_existing_aks ? (
    data.azurerm_kubernetes_cluster.existing[0].kube_admin_config[0].host
  ) : azurerm_kubernetes_cluster.main[0].kube_admin_config[0].host
  sensitive = true
}

output "admin_cluster_ca_certificate" {
  description = "Kubernetes cluster CA certificate from admin kubeconfig"
  value = var.use_existing_aks ? (
    base64decode(data.azurerm_kubernetes_cluster.existing[0].kube_admin_config[0].cluster_ca_certificate)
  ) : base64decode(azurerm_kubernetes_cluster.main[0].kube_admin_config[0].cluster_ca_certificate)
  sensitive = true
}

output "admin_client_certificate" {
  description = "Kubernetes client certificate from admin kubeconfig"
  value = var.use_existing_aks ? (
    base64decode(data.azurerm_kubernetes_cluster.existing[0].kube_admin_config[0].client_certificate)
  ) : base64decode(azurerm_kubernetes_cluster.main[0].kube_admin_config[0].client_certificate)
  sensitive = true
}

output "admin_client_key" {
  description = "Kubernetes client key from admin kubeconfig"
  value = var.use_existing_aks ? (
    base64decode(data.azurerm_kubernetes_cluster.existing[0].kube_admin_config[0].client_key)
  ) : base64decode(azurerm_kubernetes_cluster.main[0].kube_admin_config[0].client_key)
  sensitive = true
}

output "kubelet_identity" {
  description = "Kubelet managed identity object ID"
  value = var.use_existing_aks ? (
    data.azurerm_kubernetes_cluster.existing[0].kubelet_identity[0].object_id
  ) : azurerm_kubernetes_cluster.main[0].kubelet_identity[0].object_id
}

output "oidc_issuer_url" {
  description = "OIDC issuer URL for workload identity"
  value = var.use_existing_aks ? (
    data.azurerm_kubernetes_cluster.existing[0].oidc_issuer_url
  ) : azurerm_kubernetes_cluster.main[0].oidc_issuer_url
}

output "node_resource_group" {
  description = "Auto-created resource group for AKS nodes"
  value = var.use_existing_aks ? (
    data.azurerm_kubernetes_cluster.existing[0].node_resource_group
  ) : azurerm_kubernetes_cluster.main[0].node_resource_group
}

output "key_vault_secrets_provider_identity" {
  description = "Key Vault secrets provider identity"
  value = var.use_existing_aks ? (
    data.azurerm_kubernetes_cluster.existing[0].key_vault_secrets_provider[0].secret_identity[0].object_id
  ) : azurerm_kubernetes_cluster.main[0].key_vault_secrets_provider[0].secret_identity[0].object_id
}
