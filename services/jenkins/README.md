# Servicio Jenkins

Jenkins se construye con una imagen propia basada en Jenkins LTS con Java 21.

## Archivos

- `Dockerfile`: instala herramientas base y plugins.
- `config/plugins.txt`: listado de plugins preinstalados.
- `config/casc.yaml`: Jenkins Configuration as Code.

## Hardening aplicado

- Asistente inicial desactivado.
- Nodo integrado sin ejecutores.
- Seguridad remoting activa.
- CSRF crumb issuer activo.
- CSP configurada desde Terraform.

## URL por nombre

Jenkins: `http://jenkins:8080/`
