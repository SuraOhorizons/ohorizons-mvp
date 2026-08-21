# Open Horizons MVP

## Overview

Open Horizons MVP es la base de plataforma utilizada para establecer una infraestructura modular, reproducible y preparada para una migración controlada hacia el ambiente SURA.

El proyecto separa la infraestructura base de los componentes de innovación y de las integraciones específicas de producción.

El objetivo de esta etapa es construir una raíz MVP limpia que pueda ser validada antes de realizar cualquier despliegue sobre el ambiente objetivo.

## Repository

Repositorio:

```text
SuraOhorizons/ohorizons-mvp
```

Rama de trabajo:

```text
migration/sura-open-horizons-root
```

Checkpoint inicial:

```text
88bd09d chore: establish SURA Open Horizons MVP root
```

## Project Structure

```text
ohorizons-mvp/
├── README.md
└── terraform/
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    ├── README.md
    ├── terraform.tfvars.example
    ├── backend.tf.example
    ├── .terraform.lock.hcl
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

## Infrastructure MVP

La infraestructura base del MVP está implementada mediante Terraform.

Componentes principales:

- Networking
- Security
- Azure Kubernetes Service
- PostgreSQL
- Redis
- Observability
- ArgoCD
- Azure Container Registry
- External Secrets Operator

La documentación técnica está en `terraform/README.md`.

## Terraform Entry Point

El punto de entrada de la infraestructura es:

```text
terraform/main.tf
```

`main.tf` funciona como root module y orquesta los módulos de infraestructura.

```text
Terraform Root
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

## Deployment Modes

La configuración soporta:

```text
express
standard
enterprise
```

### Express

Orientado a desarrollo, validación, pruebas y ambientes temporales.

### Standard

Orientado a ambientes con mayores requisitos de disponibilidad y capacidad.

### Enterprise

Orientado a alta disponibilidad, múltiples zonas, mayor capacidad y componentes adicionales de red.

Los detalles están definidos en `terraform/main.tf`.

## Configuration

Las variables principales incluyen:

```text
customer_name
environment
azure_subscription_id
azure_tenant_id
domain_name
location
deployment_mode
```

El ejemplo se encuentra en:

```text
terraform/terraform.tfvars.example
```

Los archivos reales `*.tfvars` no deben versionarse.

## Security

El repositorio excluye:

```text
.terraform/
*.tfstate
*.tfstate.*
*.tfplan
*.tfvars
*.tfvars.json
backend.tf
crash.log
```

Esto evita almacenar state, planes, credenciales, secretos y configuración local en Git.

## Infrastructure State

El Terraform State pertenece al ambiente donde se ejecuta Terraform y no se almacena en el repositorio.

La configuración de backend se proporciona mediante:

```text
terraform/backend.tf.example
```

## Validation Workflow

```bash
terraform fmt -recursive
terraform init
terraform validate
terraform plan
```

Flujo recomendado:

```text
Change → fmt → validate → plan → Review → Commit → Push → Pull Request → Apply
```

No ejecutar `terraform apply` sobre producción sin revisar previamente el plan correspondiente.

## Migration Strategy

La rama:

```text
migration/sura-open-horizons-root
```

representa la capa de alineación y validación del MVP.

Flujo previsto:

```text
Existing Infrastructure
        │
        ▼
MVP Root
        │
        ▼
Terraform Validation
        │
        ▼
SURA Configuration
        │
        ▼
Terraform Plan
        │
        ▼
Review
        │
        ▼
Terraform Apply
```

Los valores reales de SURA se incorporarán mediante configuración específica del ambiente.

## AI / Agent / RAG Architecture

La infraestructura MVP y la integración de IA se consideran capas relacionadas pero separadas.

```text
Infrastructure MVP
       │
       ├── AKS
       ├── Networking
       ├── Security
       ├── Databases
       ├── Observability
       └── GitOps
              │
              ▼
       AI / Agent Layer
              │
              ▼
             RAG
              │
              ▼
      Production AI Agent
```

La integración del agente de IA con el backend del RAG corresponde a una etapa posterior. En particular, el consumo del agente desde el backend RAG depende de los permisos y accesos requeridos en el ambiente productivo.

Esta migración de Terraform no debe confundirse con esa etapa de integración.

## Scope Separation

### 1. MVP Infrastructure

- infraestructura base
- AKS
- networking
- seguridad
- datos
- observabilidad
- GitOps

### 2. AI / Agent Platform

- servicios de IA
- agent runtime
- integraciones de IA
- servicios necesarios para consumir el agente

### 3. Production RAG Integration

- backend RAG
- consumo del agente
- permisos de acceso
- integración con servicios productivos

Estas capas no deben mezclarse durante la migración inicial.

## Current Migration Branch

La rama utilizada es:

```text
migration/sura-open-horizons-root
```

Se utiliza para limpieza, reorganización, validación, documentación, pruebas Terraform y preparación de la configuración SURA.

`main` no forma parte de esta etapa.

## Git Workflow

```bash
git status
git diff
git add <files>
git commit -m "chore: describe change"
git push
```

Los cambios deben llegar a `main` mediante Pull Request cuando corresponda.

## Operational Principle

La infraestructura debe ser:

- reproducible
- declarativa
- modular
- versionada
- validable
- separada por ambiente
- libre de secretos en Git

## Documentation

- `README.md` — documentación general del proyecto
- `terraform/README.md` — documentación técnica de Terraform
- `terraform/terraform.tfvars.example` — ejemplo de variables
- `terraform/backend.tf.example` — ejemplo de backend
