# Arquitectura

<<<<<<< HEAD
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
=======
La plataforma queda dividida en dos capas:

1. `modules/`: módulos Terraform reutilizables.
2. `services/`: definición de imagen y configuración propia de cada producto.

## Servicios

- GitLab: `services/gitlab`
- Jenkins: `services/jenkins`
- Artifactory: `services/artifactory`

Cada servicio tiene su propio `Dockerfile`, configuración y README.
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
