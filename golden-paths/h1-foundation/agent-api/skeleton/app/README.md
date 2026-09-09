# ${{values.name}}

Backend multi-agente (FastAPI + Azure OpenAI SDK) que le da vida al **AI Chat**
integrado de Backstage (sidebar "Intelligence"). Generado desde el golden path
`h1-agent-api`.

## Qué hace

Implementa 7 agentes (`orchestrator`, `pipeline`, `sentinel`, `compass`,
`guardian`, `lighthouse`, `forge`), con:
- Enrutamiento por `@mention` o por palabras clave (`agents/router.py`)
- Streaming de respuestas vía Server-Sent Events
- Trayectorias, costos y contexto compartido (observabilidad, `middleware/`, `memory/`)
- Herramientas reales: GitHub REST API, catálogo/scaffolder de Backstage vía MCP (`tools/`)

## Endpoints principales

| Endpoint | Método | Qué hace |
|---|---|---|
| `/health` | GET | Health check |
| `/api/agents/info` | GET | Lista de agentes disponibles |
| `/api/agents/chat` | POST | Chat multi-agente (streaming SSE) |
| `/api/agents/trajectories` | GET | Resumen de trayectorias |
| `/api/agents/costs` | GET | Resumen de costos por agente |

## Variables de entorno

| Variable | De dónde sale | Sensible |
|---|---|---|
| `AZURE_OPENAI_ENDPOINT` | Key Vault (`ExternalSecret`) | Sí |
| `AZURE_OPENAI_API_KEY` | Key Vault (`ExternalSecret`) | Sí |
| `GITHUB_TOKEN` | Key Vault (`ExternalSecret`) | Sí |
| `AZURE_OPENAI_API_VERSION` | ConfigMap | No |
| `AZURE_OPENAI_DEPLOYMENT` | ConfigMap | No |
| `MODEL_DISPLAY_NAME` | ConfigMap | No |
| `CORS_ORIGINS` | ConfigMap | No |
| `LOG_LEVEL` | ConfigMap | No |

## Conectar con Backstage

Una vez desplegado, ajustar el proxy de Backstage (`app-config.production.yaml`)
para que `/agent-api` apunte al Service de este repo dentro del cluster:

```yaml
proxy:
  endpoints:
    "/agent-api":
      target: "http://${{values.name}}.${{values.namespace}}.svc.cluster.local:8008"
```

## CI/CD

`.github/workflows/despliegue-acr-sura.yml` construye la imagen y la publica en
`${{values.registry}}`. El despliegue en el cluster lo gestiona ArgoCD
(`deploy/argocd/application.yaml`), sincronizando los manifiestos de `deploy/`.
