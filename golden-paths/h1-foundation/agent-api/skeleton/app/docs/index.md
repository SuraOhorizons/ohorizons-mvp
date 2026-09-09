# ${{ values.name }}

${{ values.description }}

## Overview

Backend multi-agente (FastAPI + Azure OpenAI) que le da vida al **AI Chat** integrado
de Backstage (sidebar "Intelligence"). El frontend del chat ya viene incluido en la
imagen de Backstage — este repo es solo el backend que faltaba para que funcione.

## Getting Started

1. Crear el componente desde el catálogo de software de Backstage.
2. Completar owner, sistema, namespace y los 3 secretos de Key Vault
   (`azureOpenAIEndpointSecretKey`, `azureOpenAIApiKeySecretKey`, `githubTokenSecretKey`).
3. Revisar el repositorio generado y el workflow de CI/CD.
4. Una vez desplegado, ajustar el proxy `/agent-api` en `app-config.production.yaml`
   de Backstage para que apunte al Service de este repo dentro del cluster.
5. Verificar en Backstage → Intelligence → AI Chat que el warning "Agent backend is
   not reachable" ya no aparece.

## Generated Assets

- Metadatos de catálogo de Backstage (`catalog-info.yaml` con Component + API)
- Backend FastAPI con 7 agentes (`orchestrator`, `pipeline`, `sentinel`, `compass`,
  `guardian`, `lighthouse`, `forge`), streaming SSE, trayectorias y costos
- Dockerfile con usuario no root
- Manifiestos Kubernetes (`deploy/`) con `ExternalSecret` para las credenciales
  de Azure OpenAI y `GITHUB_TOKEN`
- CI/CD (build + push a ACR)
- Application de ArgoCD (`deploy/argocd/`)
- TechDocs
