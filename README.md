# DevOps Platform Terraform Professional

Plataforma DevOps local/profesional desplegada con Terraform sobre Docker.

Esta versión sustituye **Artifactory** por **Nexus Repository 3**, manteniendo la estructura del proyecto original y aplicando buenas prácticas de modularidad, persistencia, variables, outputs, documentación y scripts operativos.

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
