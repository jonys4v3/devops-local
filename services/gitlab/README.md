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
