# Notas de seguridad

## Secretos

- No guardes passwords en Git.
- Usa variables de entorno `TF_VAR_*` para valores sensibles.
- En producción usa un backend remoto cifrado y con bloqueo de estado.
- Protege el fichero `terraform.tfstate`, puede contener valores sensibles.

## Red

- No expongas puertos públicamente sin reverse proxy, TLS y autenticación.
- Usa firewall en el host.
- Para publicación externa, usa Nginx, Traefik o un load balancer con TLS.

## Nexus

- Cambia el password inicial de `admin` en el primer login.
- Deshabilita anonymous access si no es necesario.
- Crea roles mínimos por equipo y repositorio.
- Separa repositorios hosted, proxy y group.
- Configura cleanup policies para controlar almacenamiento.

## Jenkins

- Usa credenciales gestionadas por Jenkins Credentials.
- No guardes tokens en pipelines.
- Limita permisos de agentes y usuarios.

## GitLab

- Configura backups automáticos.
- Activa MFA para usuarios administradores.
- Revisa permisos de proyectos y grupos.
