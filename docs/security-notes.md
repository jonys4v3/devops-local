# Notas de seguridad

## Jenkins

Jenkins usa Java 21, Configuration as Code y `numExecutors: 0` para evitar builds en el controller.

## GitLab

GitLab desactiva el registro público de usuarios desde la configuración Omnibus.

## Artifactory

Artifactory incluye configuración base mediante `system.yaml`.

## Docker socket

Jenkins monta `/var/run/docker.sock`. Esto es útil para laboratorios, pero en producción conviene sustituirlo por agentes aislados.

## Actualizaciones

Ninguna plataforma puede garantizar cero vulnerabilidades permanentemente. Mantén imágenes, plugins y módulos actualizados periódicamente.
