# Arquitectura

La plataforma queda dividida en dos capas:

1. `modules/`: módulos Terraform reutilizables.
2. `services/`: definición de imagen y configuración propia de cada producto.

## Servicios

- GitLab: `services/gitlab`
- Jenkins: `services/jenkins`
- Artifactory: `services/artifactory`

Cada servicio tiene su propio `Dockerfile`, configuración y README.
