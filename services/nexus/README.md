# Nexus service

Este servicio sustituye a `services/artifactory`.

## Primer arranque

Nexus tarda varios minutos en inicializar. Para obtener el password inicial:

```bash
docker exec devops-platform-dev-nexus cat /nexus-data/admin.password
```

## Repositorios recomendados

- Maven hosted, proxy y group.
- npm hosted, proxy y group.
- Docker hosted, proxy y group.
- PyPI hosted, proxy y group.

## Migración desde Artifactory

- Artifactory local repository -> Nexus hosted repository.
- Artifactory remote repository -> Nexus proxy repository.
- Artifactory virtual repository -> Nexus group repository.
