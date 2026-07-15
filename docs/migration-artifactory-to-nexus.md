# Migración de Artifactory a Nexus

## Cambios realizados

Antes:

```text
modules/artifactory/
services/artifactory/
```

Ahora:

```text
modules/nexus/
services/nexus/
```

En `main.tf`, el antiguo bloque esperado:

```hcl
module "artifactory" {
  source = "./modules/artifactory"
}
```

queda sustituido por:

```hcl
module "nexus" {
  source = "./modules/nexus"
}
```

## Equivalencias

```text
Artifactory local repository   -> Nexus hosted repository
Artifactory remote repository  -> Nexus proxy repository
Artifactory virtual repository -> Nexus group repository
Artifactory users/groups       -> Nexus users/roles/privileges
```

## Plan recomendado

1. Dejar Artifactory en modo solo lectura.
2. Inventariar repositorios, permisos y consumidores.
3. Crear repositorios equivalentes en Nexus.
4. Migrar artefactos críticos primero.
5. Cambiar variables de pipelines CI/CD.
6. Validar builds, descargas y publicación.
7. Mantener ventana de convivencia.
8. Retirar Artifactory.
