# DevOps Platform Terraform Professional

Plataforma DevOps local/profesional desplegada con Terraform sobre Docker.

Esta versión sustituye **Artifactory** por **Nexus Repository 3**, manteniendo la estructura del proyecto original y aplicando buenas prácticas de modularidad, persistencia, variables, outputs, documentación y scripts operativos.
=======
# Plataforma DevOps profesional con Terraform, Docker, Jenkins, GitLab y Artifactory

Este proyecto despliega una plataforma DevOps local usando Terraform y Docker.

## Servicios incluidos

- GitLab CE
- Jenkins LTS con Java 21, plugins preinstalados y JCasC
- Artifactory OSS


## Estructura

```text
devops-platform-terraform-professional/
├── main.tf
├── versions.tf
├── providers.tf
├── variables.tf
├── locals.tf
├── outputs.tf
├── terraform.tfvars.example
├── modules/
│   ├── network/
│   ├── gitlab/
│   ├── jenkins/
│   └── nexus/
├── services/
│   ├── gitlab/
│   ├── jenkins/
│   └── nexus/
=======
│   └── artifactory/
├── services/
│   ├── gitlab/
│   ├── jenkins/
│   └── artifactory/
├── scripts/
└── docs/
```

## Servicios

- GitLab: `http://localhost:8080`
- Jenkins: `http://localhost:8082`
- Nexus: `http://localhost:8081`

## Uso rápido

```bash
cp terraform.tfvars.example terraform.tfvars
export TF_VAR_jenkins_admin_password="cambia-este-password"
./scripts/apply.sh
```

## Password inicial de Nexus

```bash
terraform output nexus_initial_admin_password_command
```

Luego ejecuta el comando devuelto, por ejemplo:

```bash
docker exec devops-platform-dev-nexus cat /nexus-data/admin.password
```

## Sustitución realizada

Se elimina conceptualmente:

```text
modules/artifactory/
services/artifactory/
```

y se reemplaza por:

```text
modules/nexus/
services/nexus/
```

El root `main.tf` ya referencia `module "nexus"` en lugar de `module "artifactory"`.

## Buenas prácticas incluidas

- Módulos separados por responsabilidad.
- Red Docker dedicada.
- Volúmenes persistentes para todos los servicios.
- Variables parametrizables.
- Outputs operativos.
- Labels comunes para trazabilidad.
- Healthcheck en Nexus.
- Jenkins con Configuration as Code.
- Scripts para apply, destroy, backup y healthcheck.
- Documentación de arquitectura, seguridad y migración.
=======
## Uso

```bash
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform fmt -recursive
terraform validate
terraform apply
```

También puedes usar:

```bash
./scripts/apply.sh
```

## Accesos

- Jenkins: http://jenkins:8080/
- GitLab: http://gitlab:8929/
- Artifactory: http://artifactory:8082/


## Abrir los servicios por nombre

Para acceder desde el navegador usando nombres en lugar de `localhost`, añade estas entradas al archivo `hosts` de tu sistema:

```text
127.0.0.1 jenkins gitlab artifactory
```

En Linux/macOS puedes ejecutar:

```bash
./scripts/setup_hosts_linux_macos.sh
```

En Windows ejecuta PowerShell como Administrador y lanza:

```powershell
./scripts/setup_hosts_windows.ps1
```

Después podrás abrir:

```text
http://jenkins:8080/
http://gitlab:8929/
http://artifactory:8082/
```

## Jenkins

Usuario inicial por defecto:

```text
admin
```

Contraseña por defecto:

```text
CambiarEstaPassword123!
```

Cambia la contraseña en `terraform.tfvars` antes de desplegar.

## Importante

GitLab y Artifactory usan imágenes base `latest` dentro de sus Dockerfiles para facilitar laboratorio local. Para producción, fija versiones concretas probadas en los Dockerfiles.
