# Servicio Artifactory

Artifactory OSS se construye con una imagen propia para mantener la misma estructura que Jenkins y GitLab.

## Archivos

- `Dockerfile`: imagen personalizada basada en Artifactory OSS.
- `config/system.yaml`: configuración base del nodo y router.

## Puertos

- API/servicio: `8081`
- UI/router: `8082`

## URL por nombre

Artifactory: `http://artifactory:8082/`
