<<<<<<< HEAD
# Jenkins service

Jenkins LTS con configuración básica mediante Configuration as Code.

## Acceso

- URL: `http://localhost:8082`
- Usuario: definido por `jenkins_admin_user`
- Password: definido por `TF_VAR_jenkins_admin_password` o generado por Terraform
=======
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
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
