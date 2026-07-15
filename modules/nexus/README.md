# Módulo Nexus

Este módulo reemplaza al antiguo módulo `artifactory` y despliega Sonatype Nexus Repository 3 usando Docker.

## Buenas prácticas aplicadas

- Datos persistentes en volumen Docker dedicado.
- Healthcheck HTTP contra `/service/rest/v1/status`.
- Labels comunes para trazabilidad.
- Configuración JVM parametrizable.
- Puerto separado reservado para registry Docker en Nexus.
- Outputs mínimos y no sensibles.

## Primer acceso

Después del `terraform apply`, ejecuta:

```bash
docker exec <container_name> cat /nexus-data/admin.password
```

O usa el output:

```bash
terraform output nexus_initial_admin_password_command
```
