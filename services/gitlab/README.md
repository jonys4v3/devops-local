<<<<<<< HEAD
# GitLab service

Imagen local basada en `gitlab/gitlab-ce`.

Variables principales usadas por Terraform:

- `GITLAB_EXTERNAL_URL`
- `GITLAB_SSH_PORT`
- `TZ`
=======
# Servicio GitLab

Este directorio contiene la imagen personalizada de GitLab CE y la plantilla de configuración Omnibus.

## Archivos

- `Dockerfile`: imagen base GitLab CE con metadata y healthcheck.
- `config/gitlab_omnibus_config.tpl`: configuración inyectada por Terraform mediante `GITLAB_OMNIBUS_CONFIG`.

## Puertos

- Web: `8929`
- SSH: `2222`

## URL por nombre

GitLab: `http://gitlab:8929/`
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
