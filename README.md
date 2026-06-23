# hello-world-azure-app
---

## GitLab CI/CD (Build → Docker → ACR)

This repo also contains `.gitlab-ci.yml` for GitLab pipelines.

### Required GitLab Variables
| Variable | Purpose |
|----------|---------|
| `DOCKER_HUB_USERNAME` | Docker/ACR registry username |
| `DOCKER_HUB_PASSWORD` | Docker/ACR registry password |
| `AZURE_SP_APP_ID` | Azure Service Principal App ID |
| `AZURE_SP_PASSWORD` | Azure Service Principal Secret |
| `AZURE_SP_TENANT_ID` | Azure Tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Azure Subscription ID |

### Pipeline Stages
1. **build** — dotnet restore/build/publish
2. **docker** — build image, push to ACR `helloacrdev.azurecr.io/hello-world:latest`
3. **deploy_azure** — Bicep deploy on main branch only
