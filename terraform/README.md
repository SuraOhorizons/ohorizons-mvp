# Open Horizons MVP — Terraform

## Purpose

Este directorio contiene la implementación Terraform de la infraestructura base del Open Horizons MVP.

La raíz Terraform está diseñada para ser modular, reproducible y reutilizable entre ambientes.

La configuración específica de cada ambiente debe proporcionarse mediante variables y configuración externa.

## Terraform Entry Point

El punto de entrada es:

```text
terraform/main.tf
```

Este archivo funciona como root module y orquesta los módulos:

```text
main.tf
  │
  ├── Resource Group
  ├── Networking
  ├── Security
  ├── AKS
  ├── Databases
  ├── Observability
  ├── ArgoCD
  ├── Container Registry
  └── External Secrets
```

## Directory Structure

```text
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── README.md
├── terraform.tfvars.example
├── backend.tf.example
├── .terraform.lock.hcl
├── .tflint.hcl
└── modules/
    ├── aks-cluster/
    ├── argocd/
    ├── container-registry/
    ├── databases/
    ├── external-secrets/
    ├── networking/
    ├── observability/
    └── security/
```

Cada módulo contiene normalmente `main.tf`, `variables.tf`, `outputs.tf`, `versions.tf`, `README.md` y `.tflint.hcl`.

## Modules

### Networking

`modules/networking/`

Responsabilidades:

- Virtual Network
- AKS subnets
- PostgreSQL subnet
- Private Endpoint subnet
- Bastion subnet
- Application Gateway subnet
- Network Security Groups
- Private DNS
- DNS configuration

### Security

`modules/security/`

Responsabilidades:

- Azure Key Vault
- Managed Identities
- configuración de seguridad
- acceso a secretos

### AKS

`modules/aks-cluster/`

Responsabilidades:

- Azure Kubernetes Service
- system node pool
- workload node pool
- autoscaling
- Availability Zones
- Entra ID integration
- configuración Kubernetes base

La capacidad depende de `deployment_mode`.

### Databases

`modules/databases/`

Incluye:

- Azure Database for PostgreSQL
- Redis

Control:

```hcl
enable_databases
```

### Observability

`modules/observability/`

Incluye componentes relacionados con:

- Prometheus
- Grafana
- Azure Monitor

Control:

```hcl
enable_observability
```

### ArgoCD

`modules/argocd/`

Responsabilidades:

- GitOps
- ArgoCD
- configuración de acceso
- integración GitHub

Control:

```hcl
enable_argocd
```

### Container Registry

`modules/container-registry/`

Responsable de Azure Container Registry.

Control:

```hcl
enable_container_registry
```

### External Secrets

`modules/external-secrets/`

Responsable de:

- External Secrets Operator
- integración con Azure Key Vault
- gestión de secretos desde Kubernetes

Control:

```hcl
enable_external_secrets
```

## Root Variables

Las variables del root module están definidas en `variables.tf`.

Variables obligatorias:

```text
customer_name
environment
azure_subscription_id
azure_tenant_id
domain_name
```

## Deployment Modes

### Express

Orientado a desarrollo, validación, pruebas y ambientes temporales.

Configuración base:

```text
AKS nodes: 3
AKS size: Standard_D4s_v5
HA: false
Monitoring: true
Databases: true
AI base configuration: false
```

### Standard

```text
AKS nodes: 5
AKS size: Standard_D4s_v5
HA: true
Monitoring: true
Databases: true
```

### Enterprise

```text
AKS nodes: 10
AKS size: Standard_D8s_v5
HA: true
Monitoring: true
Databases: true
```

## Configuration

Utilizar:

```text
terraform.tfvars.example
```

como plantilla.

Ejemplo:

```hcl
customer_name         = "sura"
environment           = "dev"
azure_subscription_id = "..."
azure_tenant_id       = "..."
domain_name           = "internal.local"
location              = "brazilsouth"
deployment_mode       = "express"
```

Los valores reales no deben almacenarse en Git.

## Backend

El repositorio contiene:

```text
backend.tf.example
```

como referencia.

El backend real se configura en:

```text
backend.tf
```

pero este archivo está excluido mediante `.gitignore`.

Terraform State tampoco debe versionarse:

```text
*.tfstate
*.tfstate.*
*.tfplan
backend.tf
*.tfvars
```

## Providers

Los providers están definidos en `main.tf` y bloqueados mediante `.terraform.lock.hcl`.

Providers utilizados:

```text
hashicorp/azurerm
hashicorp/azuread
azure/azapi
hashicorp/kubernetes
hashicorp/helm
gavinbunney/kubectl
integrations/github
hashicorp/random
```

El lock file debe permanecer versionado.

## Initialization

```bash
terraform init -backend=false
```

Inicialización normal:

```bash
terraform init
```

Si cambia la configuración del backend:

```bash
terraform init -reconfigure
```

## Formatting

```bash
terraform fmt -recursive
terraform fmt -recursive -check
```

## Validation

```bash
terraform validate
```

Una validación correcta debe terminar con:

```text
Success! The configuration is valid
```

Pueden aparecer warnings del provider sin impedir la validación.

## Planning

```bash
terraform plan
```

Para guardar el plan:

```bash
terraform plan -out=tfplan
terraform show tfplan
```

Los archivos `*.tfplan` son locales y están excluidos de Git.

## Apply

No ejecutar `apply` sobre un ambiente productivo sin revisar previamente el plan.

Flujo recomendado:

```bash
terraform plan   -var-file=environments/sura.tfvars   -out=sura.tfplan

terraform show sura.tfplan

terraform apply sura.tfplan
```

El nombre y ubicación final del archivo de variables de SURA dependerán de la estructura definitiva del repositorio.

## Environment Separation

El código Terraform debe permanecer genérico.

Los valores específicos de SURA deben proporcionarse externamente:

```text
subscription
tenant
resource naming
location
domain
credentials
GitHub configuration
```

No modificar módulos únicamente para introducir valores específicos de un ambiente.

## MVP Scope

La raíz actual contiene:

```text
Networking
Security
AKS
Databases
Observability
ArgoCD
Container Registry
External Secrets
```

Componentes retirados de esta raíz durante la limpieza:

```text
Defender
Purview
GitHub Runners
Cost Management
AI Foundry
Disaster Recovery
Foundry Agents
Agent API Impact
Agent API MAF
Agent API Semantic Kernel
MCP Ecosystem
```

Estos componentes no deben interpretarse como eliminados del producto final. Quedan fuera del alcance de esta raíz MVP durante la migración controlada.

## AI / RAG Separation

La infraestructura Terraform MVP debe considerarse una capa independiente de la integración final de IA.

```text
Terraform MVP
      │
      ▼
Platform Infrastructure
      │
      ├── AKS
      ├── Networking
      ├── Security
      ├── Databases
      └── Observability
              │
              ▼
        AI / Agent Layer
              │
              ▼
             RAG
              │
              ▼
      Production Integration
```

La integración del agente con el backend RAG requiere una etapa independiente de permisos, acceso y configuración productiva.

## Validation Checklist

Antes de commit:

```bash
terraform fmt -recursive -check
terraform validate
git diff --check
git status
```

Antes de Pull Request:

```bash
terraform plan
git diff
```

Antes de `apply`:

```text
[ ] Terraform initialized
[ ] Correct backend selected
[ ] Correct subscription
[ ] Correct tenant
[ ] Correct environment
[ ] Correct tfvars
[ ] Plan reviewed
[ ] No unexpected resource destruction
[ ] Secrets are not exposed
[ ] Approval obtained
```

## Git Workflow

Rama actual:

```text
migration/sura-open-horizons-root
```

Flujo:

```text
Modify
  │
  ▼
fmt
  │
  ▼
validate
  │
  ▼
plan
  │
  ▼
review
  │
  ▼
commit
  │
  ▼
push
  │
  ▼
Pull Request
```

No trabajar directamente sobre `main` durante esta etapa.

## Current Checkpoint

Commit inicial:

```text
88bd09d chore: establish SURA Open Horizons MVP root
```

Repository:

```text
SuraOhorizons/ohorizons-mvp
```

Branch:

```text
migration/sura-open-horizons-root
```

Este checkpoint representa la primera versión persistida de la raíz Terraform MVP después de la limpieza y separación de componentes.

## Operational Rules

1. No subir secretos.
2. No subir Terraform State.
3. No subir Terraform Plans.
4. No subir `backend.tf`.
5. Mantener `.terraform.lock.hcl` versionado.
6. Validar Terraform antes de cada commit.
7. Revisar siempre el plan antes de `apply`.
8. Mantener separada la configuración de cada ambiente.
9. No mezclar la integración productiva del agente RAG con la limpieza inicial del MVP.
10. Utilizar Pull Requests para integrar cambios a `main`.
