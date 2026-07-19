# Arquitectura

Esta plataforma DevOps se despliega con Terraform sobre Docker y contiene:

- **Network**: red bridge dedicada para aislar los servicios.
- **GitLab**: repositorios Git y gestión de código.
- **Jenkins**: automatización CI/CD.
- **Nexus Repository 3**: gestor de artefactos, sustituyendo a Artifactory.

## Diagrama lógico

```text
              ┌──────────────────────────────┐
              │ Docker network               │
              │ devops-platform-dev-net      │
              └──────────────┬───────────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
┌───────▼───────┐    ┌───────▼───────┐    ┌───────▼───────┐
│ GitLab        │    │ Jenkins       │    │ Nexus         │
│ :8080 / :2222 │    │ :8082/:50000  │    │ :8081/:8083  │
└───────┬───────┘    └───────┬───────┘    └───────┬───────┘
        │                    │                    │
  Docker volumes       Docker volume        Docker volume
```

## Reemplazo Artifactory -> Nexus

Se elimina la ruta `modules/artifactory` y `services/artifactory`, quedando:

```text
modules/nexus/
services/nexus/
```

El patrón de uso se mantiene equivalente para facilitar la sustitución en pipelines y documentación.
